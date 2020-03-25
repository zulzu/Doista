//
//  SwipeTableViewController.swift
//  TodoMaster
//
//  Created by Andras Pal on 23/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import UIKit

class SwipeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 65.0
        tableView.separatorStyle = .none
        
    }
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete",
                                          handler: handleRowAction)
        let edit = UITableViewRowAction(style: .normal, title: "Edit",
                                        handler: handleRowAction)
        edit.backgroundColor = UIColor.blue
        
        return [edit, delete]
        
    }
    
    func handleRowAction(action: UITableViewRowAction, indexPath: IndexPath){
        print("Action is \(action.title!) at Index Path \(indexPath)")
        
        let actionItem = action.title
        switch actionItem {
            
        case "Delete":
            print("Delete function")
//            myArray.remove(at: indexPath.row)
//            myTableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            
        case "Edit":
            print("Edit function")
//            let alert = UIAlertController(title: "Edit Row Entry",
//                                          message: nil,
//                                          preferredStyle: .alert)
//
//            alert.addTextField { (textField: UITextField) in
//                textField.keyboardAppearance = .dark
//                textField.keyboardType = .default
//                textField.autocorrectionType = .default
//                textField.placeholder = self.myArray[indexPath.row]
//            }
//
//            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
//                self.myArray[indexPath.row] = alert.textFields![0].text!
//                self.myTableView.reloadRows(at: [indexPath], with: .top)
//            }))
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
//                print("Edit Cancelled...")}))
//
//            self.present(alert, animated: true)

            
        default:
            print("Default just in case")
        }
        
    }
    
    
    
    
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
    }
    
}

