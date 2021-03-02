//
//  Strings.swift
//  Doista
//
//  Created by Andras Pal on 02/03/2021.
//  Copyright © 2021 Andras Pal. All rights reserved.
//

import Foundation

/// A key for retrieving a String that can be displayed to the user
enum StringKey: String, CaseIterable {
    
    /// A generic error message
    case errorMsg
    /// The text: "Add a new category"
    case addCategory
    /// The label: "Add"
    case add
    /// The word "Cancel"
    case cancel
    /// The label: "Category name"
    case categoryName
    /// The label: "Edit category"
    case editCategory
    /// The word "Update"
    case update
    /// The label: "New name"
    case newName
    /// The label: "No items added"
    case noItems
    /// The label: "Add a new item"
    case addItem
    /// The label: "Item name"
    case itemName
    /// The label: "Edit item"
    case editItem
    /// The word "Delete"
    case delete
    /// The word "Edit"
    case edit
}

extension String {
    
    /// Retrieves any non-database stored strings for the app.
    /// - Parameter stringKey: An instance of StringKey
    /// - Returns: A String
    static func getString(_ stringKey: StringKey) -> String {
        guard let string = StringProvider.strings[stringKey] else {
            assertionFailure("A String could not be retreived for StringKey: '\(stringKey.rawValue)'")
            return "MISSING TEXT"
        }
        return string
    }
}

fileprivate struct StringProvider {
    
    /// A dictionary containing all the static strings for the app
    static var strings: [StringKey: String] {
        [
            .errorMsg: "Error, something went wrong!",
            .addCategory: "Add a new category",
            .add: "Add",
            .cancel: "Cancel",
            .categoryName: "Category name",
            .editCategory: "Edit category",
            .update: "Update",
            .newName: "New name",
            .noItems: "No items added",
            .addItem: "Add a new item",
            .itemName: "Item name",
            .editItem: "Edit item",
            .delete: "Delete",
            .edit: "Edit"
        ]
    }
}
