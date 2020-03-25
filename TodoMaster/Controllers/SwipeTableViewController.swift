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
    
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
    }
    
}

