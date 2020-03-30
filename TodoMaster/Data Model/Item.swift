//
//  Item.swift
//  TodoMaster
//
//  Created by Andras Pal on 17/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    @objc dynamic var order = 0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    override static func primaryKey() -> String? {
        return "order"
    }
    
    static func incrementalID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Item.self).max(ofProperty: "order") as Int? ?? 0) + 1
    }
    
}


