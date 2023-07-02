//
//  ToDoItem.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation

struct ToDoItem{
    init(title: String, itemDescription: String? = nil){
        self.title = title
        self.description = itemDescription
    }
    let title: String
    let description: String?
}
