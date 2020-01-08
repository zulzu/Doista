//
//  CategoryViewController.swift
//  TodoMaster
//
//  Created by Andras Pal on 15/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import UIKit
import RealmSwift
//import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    lazy var realm = try! Realm ()
    //    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
                
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
//            guard let categoryColour = UIColor(hexString: category.color) else {fatalError()}
            let categoryColour = UIColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.3)
            cell.backgroundColor = categoryColour
//            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
//        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
//        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "009CFE")
        
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
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
//            newCategory.color = UIColor.randomFlat().hexValue()
            newCategory.color = "blue"
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
    
    
    
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
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}
