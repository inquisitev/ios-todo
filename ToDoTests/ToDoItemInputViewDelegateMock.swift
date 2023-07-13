//
//  ToDoItemInputViewDelegateMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/9/23.
//

import Foundation
@testable import ToDo

class ToDoItemInputViewDelegateMock: ToDoItemInputViewDelegate
{
    var item: ToDoItemData?
    var coordinate: Coordinate?
    func addToDoItem(with: ToDoItemData, coordinate: ToDo.Coordinate?) {
        item = with
        self.coordinate = coordinate
    }
    
    
}
