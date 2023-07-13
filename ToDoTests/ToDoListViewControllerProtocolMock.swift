//
//  ToDoListViewControllerProtocolMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/7/23.
//

import Foundation
@testable import ToDo
import UIKit

class ToDoListViewControllerProtocolMock: ToDoListViewControllerProtocol{
    var selectToDoItemReceivedArgs: (viewController: UIViewController
                                      , item: ToDoItem)?
    
    var addToDoItemCallCount: Int = 0
    func selectToDoItem(_ viewController: UIViewController, item: ToDo.ToDoItem) {
        selectToDoItemReceivedArgs = (viewController, item)
    }
    
    func addToDoItem(_ viewController: UIViewController) {
        addToDoItemCallCount += 1
        
    }
    
    
}
