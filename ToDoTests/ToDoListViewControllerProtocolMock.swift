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
    func selectToDoItem(_ viewController: UIViewController, item: ToDo.ToDoItem) {
        selectToDoItemReceivedArgs = (viewController, item)
    }
    
    
}
