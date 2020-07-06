//
//  SwipeTableViewController.swift
//  Doista
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
        
        //        self.tableView.isScrollEnabled = tableView.contentSize.height < tableView.frame.height
        
    }
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    //Adding the delete and edit functionality to swipe
    //Need to update the code later for the UIContextualAction
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            let delete = UITableViewRowAction(style: .destructive, title: "Delete",
                                              handler: handleRowAction)
            delete.backgroundColor = UIColor(red: 241/255, green: 94/255, blue: 14/255, alpha: 1.0)
            
            let edit = UITableViewRowAction(style: .normal, title: "Edit",
                                            handler: handleRowAction)
            edit.backgroundColor = UIColor(red: 120/255, green: 0/255, blue: 255/255, alpha: 1.0)
            
            return [delete, edit]
    }
    
    //handler for tableView swipe action
    func handleRowAction(action: UITableViewRowAction, indexPath: IndexPath){
        let actionItem = action.title
        switch actionItem {
            
        case "Edit":
            self.editModel(at: indexPath)
            
        case "Delete":
            self.updateModel(at: indexPath)
            
        default:
            print("Default just in case")
        }
    }
    
    func updateModel(at indexPath: IndexPath) {
        //code updates in CategoryViewController and TodoListViewController accordingly
    }
    
    func editModel(at indexPath: IndexPath) {
        //code updates in CategoryViewController and TodoListViewController accordingly
    }
    
}

