//
//  CategoryViewController.swift
//  Doista
//
//  Created by Andras Pal on 15/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    lazy var realm = try! Realm ()
    //    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadCategories()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textMainColour]
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            let categoryColour = UIColor(hex: category.color)
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
        }
        
        return cell
    }
    
    //MARK: - TableVIew Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: String.getString(.addCategory), message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: String.getString(.add), style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomRGBA.rgbaColoursToHex()!
            newCategory.categoryID = Category.incrementalIDCat()
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: String.getString(.cancel), style: .cancel, handler: nil))
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = String.getString(.categoryName)
        }
        
        alert.preferredAction = action
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Data Manipulation Methods
    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion.items)
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
        tableView.reloadData()
    }
    
    //MARK: Edit Data From Swipe
    override func editModel(at indexPath: IndexPath) {
        
        var textField = UITextField()
        let updatedCategory = self.categories?[indexPath.row]
        let alert = UIAlertController(title: String.getString(.editCategory), message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: String.getString(.update), style: .default) { (action) in
            
            if self.categories?[indexPath.row] != nil {
                do {
                    try self.realm.write {
                        updatedCategory?.name = textField.text!
                        self.realm.add(updatedCategory!, update: .all)
                    }
                } catch {
                    print("Error savig new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = String.getString(.newName)
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: String.getString(.cancel), style: .cancel, handler: nil))
        alert.preferredAction = action
        present(alert, animated: true, completion: nil)
    }
}
