//
//  Category.swift
//  TodoMaster
//
//  Created by Andras Pal on 17/07/2019.
//  Copyright © 2019 Andras Pal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
