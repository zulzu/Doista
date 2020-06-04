//
//  SwipeTableViewController.swift
//  Doodoo
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
            
            let edit = UITableViewRowAction(style: .normal, title: "Edit",
                                            handler: handleRowAction)
            edit.backgroundColor = UIColor.blue
            
            return [delete, edit]
    }
    
    func handleRowAction(action: UITableViewRowAction, indexPath: IndexPath){
        print("Action is \(action.title!) at Index Path \(indexPath)")
        
        let actionItem = action.title
        switch actionItem {
            
        case "Edit":
            print("Edit function")
            
            self.editModel(at: indexPath)

            
  case "Delete":
      print("Delete function")
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

