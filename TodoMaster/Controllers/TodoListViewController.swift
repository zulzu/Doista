//
//  ViewController.swift
//  TodoMaster
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
        updateNavBar(withHexCode: "1D9BF6")
    }
    
    //MARK: - Nav Bar Setup Methods
    
    func updateNavBar(withHexCode colourHexCode: String){
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
//        guard let navBarColour = UIColor(hexString: colourHexCode) else { fatalError()}
//        let navBarColour = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.3)
        
        let navBarColour = UIColor(hex: selectedCategory!.color)

        //                let navBarColour = FlatWhite()
        navBar.barTintColor = navBarColour
//        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
//        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
        navBar.tintColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 0.8)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)]
        searchBar.barTintColor = navBarColour
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

//                cell.backgroundColor = color
            cell.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)

//                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                cell.textLabel?.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.9)
//            }
            
//            cell.textLabel?.attributedText =  nil
            
//cell.textLabel?.attributedText = item.title.strikeThrough()
            
            cell.accessoryType = item.done ? .checkmark : .none
            
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
                    //                    realm?.delete(item)
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
        
        let alert = UIAlertController(title: "Add new TodoMaster Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm?.write {
                        let newItem = Item()
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
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - Model Manipulation Methods
    
    
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
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
    }
    
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
                todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
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

