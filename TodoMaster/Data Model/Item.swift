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
    @objc dynamic var order: Int = 0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

