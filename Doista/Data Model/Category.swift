//
//  Category.swift
//  Doista
//
//  Created by Andras Pal on 17/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import Foundation
import RealmSwift


/// A Category Realm object. 
class Category: Object {
    
    // The name of the category
    @objc dynamic var name: String = ""
    // The colour of the category
    @objc dynamic var color: String = ""
    // The ID of the category
    @objc dynamic var categoryID: Int = 0
    // The Item subclass
    let items = List<Item>()
    
    override static func primaryKey() -> String? {
        return "categoryID"
    }
    
    static func incrementalIDCat() -> Int {
        let realm = try! Realm()
        return (realm.objects(Category.self).max(ofProperty: "categoryID") as Int? ?? 0) + 1
    }
}
