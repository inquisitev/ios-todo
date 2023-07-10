//
//  ToDoItem.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation

struct ToDoItem: Equatable, Codable{
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(title: String, itemDescription: String? = nil, timeStamp: TimeInterval? = nil, location: Location? = nil){
        self.id = UUID()
        self.title = title
        self.description = itemDescription
        self.timeStamp = timeStamp
        self.location = location
    }
    let id: UUID
    let title: String
    let description: String?
    let timeStamp: TimeInterval?
    let location: Location?
    var done: Bool = false
}

extension ToDoItem: Hashable{
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}
