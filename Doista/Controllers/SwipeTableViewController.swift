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
    
    func handleRowAction(action: UITableViewRowAction, indexPath: IndexPath){
        print("Action is \(action.title!) at Index Path \(indexPath)")
        print("deleted line \(indexPath.row)")

        
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
        // Update our data model
    }
    
    func editModel(at indexPath: IndexPath) {
        //Update our data model
    }
    
    
}
