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
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
    -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: String.getString(.delete), handler: handleRowAction)
        delete.backgroundColor = UIColor.deleteButton
        
        let edit = UITableViewRowAction(style: .normal, title: String.getString(.edit), handler: handleRowAction)
        edit.backgroundColor = UIColor.editButton

        return [delete, edit]
    }
    
    //handler for tableView swipe action
    func handleRowAction(action: UITableViewRowAction, indexPath: IndexPath){
        let actionItem = action.title
        switch actionItem {
        
        case String.getString(.delete):
            self.updateModel(at: indexPath)
        case String.getString(.edit):
            self.editModel(at: indexPath)
        default:
            print("Table view action title mismatch")
        }
    }
    
    func updateModel(at indexPath: IndexPath) {
        //code updates in CategoryViewController and TodoListViewController accordingly
    }
    
    func editModel(at indexPath: IndexPath) {
        //code updates in CategoryViewController and TodoListViewController accordingly
    }
}
