//
//  ToDoItem.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation

struct ToDoItem{
    init(title: String, itemDescription: String? = nil, timeStamp: TimeInterval? = nil, location: Location? = nil){
        self.title = title
        self.description = itemDescription
        self.timeStamp = timeStamp
        self.location = location
    }
    let title: String
    let description: String?
    let timeStamp: TimeInterval?
    let location: Location?
}
