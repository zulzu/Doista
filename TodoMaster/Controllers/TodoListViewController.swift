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
        
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight))
//
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//
//        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//
//        self.view.addGestureRecognizer(swipeLeft)
//
//        self.view.addGestureRecognizer(swipeRight)
        swipeGesture()

        
        self.tableView.isEditing = false
    }
    
    func swipeGesture(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if (sender.direction == .left)
        {
           print("Swipe Left")

        }

        if (sender.direction == .right)
        {
           print("Swipe Right")

        }
    }
    

//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt IndexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
//            let deletedObject = self.todoItems?[IndexPath.row]
//            try! self.realm?.write {
//                self.realm?.delete(deletedObject!)
//            }
//
////            self.todoItems.remove(at: indexPath.row)
////            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            complete(true)
//        }
//
//        deleteAction.backgroundColor = .red
//
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
//
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, editActionsForRowAt IndexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
////            self.Items.remove(at: indexPath.row)
////            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            let movedObject = self.todoItems?[IndexPath.row]
//            try! self.realm?.write {
//                self.realm?.delete(movedObject!)
//            }
//        }
//        deleteAction.backgroundColor = .red
//        return [deleteAction]
//    }
    
//    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
//
//    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedObject = self.todoItems?[sourceIndexPath.row]
//
//        try! realm?.write {
//            realm?.delete(movedObject!)
//        }
////
////
////   //     todoItems.remove(at: sourceIndexPath.row)
////   //     todoItems.insert(movedObject, at: destinationIndexPath.row)
////    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
        guard let colourHex = selectedCategory?.color  else { fatalError()}
        updateNavBar(withHexCode: colourHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#36648B")]
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#36648B")
    }
    
    //MARK: - Nav Bar Setup Methods
    
    func updateNavBar(withHexCode colourHexCode: String){
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
         
        let navBarColour = UIColor(hex: selectedCategory!.color)
        navBar.barTintColor = navBarColour
        navBar.tintColor = navBarColour?.withAlphaComponent(0.5)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : navBarColour?.withAlphaComponent(0.5)]
//        searchBar.barTintColor = navBarColour?.withAlphaComponent(0.5)
//        searchBar.barTintColor = navBarColour
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
    
//    //MARK: Delete Data From Swipe
//
//    override func updateModel(at indexPath: IndexPath) {
//        if let item = todoItems?[indexPath.row] {
//            do {
//                try realm?.write {
//                    realm?.delete(item)
//                }
//            } catch {
//                print("Error deleting item, \(error)")
//            }
//        }
//    }
    
}

////MARK: - Search bar methods
//
//extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//                todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
////        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
//
//        tableView.reloadData()
//
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}
//MARK: - Extensions
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
