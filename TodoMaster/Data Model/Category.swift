//
//  Category.swift
//  Doista
//
//  Created by Andras Pal on 17/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var order = 0
    
    let items = List<Item>()
    
    override static func primaryKey() -> String? {
        return "order"
    }
    
    static func incrementalIDCat() -> Int {
        let realm = try! Realm()
        return (realm.objects(Category.self).max(ofProperty: "order") as Int? ?? 0) + 1
    }
    
    
}
