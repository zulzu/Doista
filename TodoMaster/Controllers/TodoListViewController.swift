//
//  ViewController.swift
//  Doodoo
//
//  Created by Andras Pal on 22/04/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    
    var todoItems: Results<Item>?
    let realm = try? Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
                        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
        guard let colourHex = selectedCategory?.color  else { fatalError()}
        updateNavBar(withHexCode: colourHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#212121")!]
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#ffffff")
    }
    
    //MARK: - Nav Bar Setup Methods
    
    func updateNavBar(withHexCode colourHexCode: String){
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
         
        let navBarColour = UIColor(hex: selectedCategory!.color)
        navBar.barTintColor = navBarColour
        navBar.tintColor = navBarColour?.withAlphaComponent(0.7)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : navBarColour?.withAlphaComponent(0.7) as Any]
        
    }
    
    
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
//            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {

//            let itemNumber : Int = Int(todoItems?[indexPath.row] ?? 1)
//            let itemAlpha = Int(1 - ((item * 3)/100))
            
            cell.backgroundColor = UIColor(hex: selectedCategory!.color)
            
                cell.textLabel?.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.9)
//            }
            
            
//            cell.accessoryType = item.done ? .checkmark : .none
            
            if item.done == false {
                cell.textLabel?.attributedText =  nil
                cell.textLabel?.text =  item.title
            } else {
                cell.textLabel?.attributedText = item.title.strikeThrough()
            }
            
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell

        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm?.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm?.write {
                        let newItem = Item()
                        newItem.order = Item.incrementalIDItem()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error savig new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item name"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.preferredAction = action
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - Model Manipulation Methods
    
    
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    //MARK: Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm?.write {
                    realm?.delete(item)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
         tableView.reloadData()
    }
    
    //MARK: Edit Data From Swipe

        override func editModel(at indexPath: IndexPath) {
            var textField = UITextField()
            
            let updatedItem = self.todoItems?[indexPath.row]

            let alert = UIAlertController(title: "Edit item", message: "", preferredStyle: .alert)

            let action = UIAlertAction(title: "Update", style: .default) { (action) in

                if self.selectedCategory?.items != nil {
                    do {
                        try self.realm?.write {
                            updatedItem?.title = textField.text!
                            self.realm?.add(updatedItem!, update: .all)
                        }
                    } catch {
                        print("Error savig new items, \(error)")
                    }
                }

                self.tableView.reloadData()
            }
        
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "New name"
                textField = alertTextField
            }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.preferredAction = action
        present(alert, animated: true, completion: nil)
        
        
    }
    

    
}



//MARK: - Extensions

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

