//
//  AppCoordinatorTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/11/23.
//

import Foundation
import XCTest
import SwiftUI
@testable import ToDo

class AppCoordinateTests: XCTestCase{
    var sut: AppCoordinator!
    var navigationControllerMock: NavigationcontrollerMock!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        navigationControllerMock = NavigationcontrollerMock()
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock, toDoItemStore: ToDoItemStore(fileName: "dummy_store"))
    }
    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
        
        let url = FileManager.default.documentsURL(name: "dummy_store")
        try? FileManager.default.removeItem(at: url)
    }
    
    func test_start_shouldSetDelegate() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemListViewController)
        
        XCTAssertIdentical(listViewController.delegate as? AppCoordinator, sut)
        
    }
    
    func test_start_shouldAssignItemStore() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemListViewController)
        
        XCTAssertNotNil (listViewController.toDoItemStore)
    }
    
    func test_selectToDoItem_pushesDetails() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "Dummy")
        sut.selectToDoItem(dummyViewController, item: item)
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertEqual(detail.toDoItem, item)
    }
    
    func test_selectToDoItem_sharesItemStore() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "Dummy")
        sut.selectToDoItem(dummyViewController, item: item)
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertIdentical(detail.toDoItemStore as? ToDoItemStore, sut.toDoItemStore)
    }
    
    func test_addToDoItem_shouldPresentView() throws {
        let viewControllerMock = ViewControllerMock()
        sut.addToDoItem(viewControllerMock)
        let lastPresented = try XCTUnwrap(viewControllerMock.lastPresentedController as? UIHostingController<ToDoItemInputView>)
        
        XCTAssertIdentical(lastPresented.rootView.delegate as? AppCoordinator, sut)
    }
    
    
    func test_addToDoItemWith_shouldCallToDoItemStore() throws {
        let toDoItemData = ToDoItemData()
        toDoItemData.title = "Dummy Title"
        let receivedItems = try wait(for: sut.toDoItemStore.itemPublisher, afterChange: {
            sut.addToDoItem(with: toDoItemData, coordinate: nil)
        })
        
        XCTAssertEqual(receivedItems.first?.title, toDoItemData.title)
    }
    
    func test_saveButton_shouldDismissModal(){
        let toDoItemData = ToDoItemData()
        toDoItemData.title = "Dummy Title"
        sut.addToDoItem(with: toDoItemData, coordinate: nil)
        
        XCTAssertEqual(navigationControllerMock.dismissed, true)
    }
}
