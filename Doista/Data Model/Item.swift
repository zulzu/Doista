//
//  Item.swift
//  Doista
//
//  Created by Andras Pal on 17/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import Foundation
import RealmSwift

/// An Item Realm object. Subclass of Category.
class Item: Object {
    
    // The title of the todo list item
    @objc dynamic var title: String = ""
    // The boolen to track the completion of the item
    @objc dynamic var isCompleted: Bool = false
    // The date when the item is created
    @objc dynamic var dateCreated: Date?
    // The ID of the item
    @objc dynamic var itemID: Int = 0
    // The parent category of the Item class
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    override static func primaryKey() -> String? {
        return "itemID"
    }
    
    static func incrementalIDItem() -> Int {
        let realm = try! Realm()
        return (realm.objects(Item.self).max(ofProperty: "itemID") as Int? ?? 0) + 1
    }
}
