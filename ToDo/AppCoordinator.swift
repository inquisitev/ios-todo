//
//  AppCoordinator.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/10/23.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator{
    func start()
}


class AppCoordinator: Coordinator{
    
    private let window: UIWindow?
    private let viewController: UIViewController
    private let navigationController: UINavigationController
    let toDoItemStore: ToDoItemStore
    
    init(window: UIWindow?, navigationController: UINavigationController = UINavigationController(), toDoItemStore: ToDoItemStore = ToDoItemStore()) {
        self.window = window
        self.navigationController = navigationController
        self.toDoItemStore = toDoItemStore
        let storyBoard = UIStoryboard(name:"Main", bundle: nil)
        viewController = storyBoard.instantiateViewController(withIdentifier: "ToDoItemListViewController")
        
    }
    func start() {
        navigationController.pushViewController(viewController, animated: false)
        window?.rootViewController = navigationController
        if let listViewController = viewController as? ToDoItemListViewController
        {
            listViewController.delegate = self
            listViewController.toDoItemStore = toDoItemStore
        }
    }
    
    
}


extension AppCoordinator: ToDoListViewControllerProtocol{
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let next = (storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as? ToDoItemDetailsViewController)
        else{
            return
        }
        
        next.loadViewIfNeeded()
        next.toDoItem = item
        next.toDoItemStore = toDoItemStore
        navigationController.pushViewController(next, animated: false)
                
    }
    
    func addToDoItem(_ viewController: UIViewController) {
        let data = ToDoItemData()
        let next = UIHostingController<ToDoItemInputView>(
            rootView: ToDoItemInputView(data: data, apiClient: APIClient(), delegate: self)
        )
        
        viewController.present(next, animated: true)
    }
    
    
}

extension AppCoordinator: ToDoItemInputViewDelegate{
    func addToDoItem(with: ToDoItemData, coordinate: Coordinate?) {
        let location = Location(name: with.locationName, coordinate: coordinate)
        let item = ToDoItem(title: with.title, itemDescription: with.description, timeStamp: with.date.timeIntervalSince1970, location: location)
        toDoItemStore.add(item)
        navigationController.dismiss(animated: true)
    }
    
    
}
