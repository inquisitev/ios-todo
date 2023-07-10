//
//  ToDoItemStoreMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/4/23.
//

import Foundation
import Combine

@testable import ToDo

class ToDoItemStoreMock: ToDoItemStoreProtocol{
    var itemPublisher = CurrentValueSubject<[ToDo.ToDoItem], Never>([])
    
    var checkLastCallArgument: ToDoItem?
    
    func check(_ item: ToDoItem) {
        checkLastCallArgument = item
    }
    
    
}
