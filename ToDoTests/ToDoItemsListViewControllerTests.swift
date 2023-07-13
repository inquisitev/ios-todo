//
//  ToDoItemsListViewControllerTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/3/23.
//

import XCTest
@testable import ToDo
class ToDoItemsListViewControllerTests: XCTestCase{
    var sut: ToDoItemListViewController?
    var toDoItemStoreMock: ToDoItemStoreMock!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name:
                                        "Main", bundle: nil)
        sut = try XCTUnwrap(storyboard.instantiateViewController(withIdentifier: "ToDoItemListViewController") as? ToDoItemListViewController)
        toDoItemStoreMock = ToDoItemStoreMock()
        sut?.toDoItemStore = toDoItemStoreMock
        sut!.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_init_storyboardNotNull(){
        XCTAssertNotNil(sut)
    }
    
    func test_table_is_descendent(){
        XCTAssertTrue(sut!.tableView.isDescendant(of: sut!.view))
    }
    
    func test_table_receivesPublishedItem(){
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "Dummy")])
        
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 1)
    }
    
    
    func test_table_receivesPublishedItems(){
        toDoItemStoreMock.itemPublisher.send([
            ToDoItem(title: "Dummy"),
            ToDoItem(title: "Dummy2"),
        ])
        
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_table_cellHasTitle() throws {
        let title = "Title"
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: title)])
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, title)
    }
    
    
    func test_table_cellHasDifferentTitle() throws {
        let title = "Title2"
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: title)])
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, title)
    }
    
    func test_cell_has_location() throws {
        let item = ToDoItem(title: "Dummy", location: Location(name: "location", coordinate: Coordinate(latitude: 30.2, longitude: 33.2)))
        
        toDoItemStoreMock.itemPublisher.send([item])
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.locationLabel.text, item.location?.name)
    }
    
    
    func test_cell_has_date() throws {
        let date = Date()
        let item = ToDoItem(title: "Dummy", timeStamp: date.timeIntervalSince1970)
        
        toDoItemStoreMock.itemPublisher.send([item])
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.dateLabel.text, sut?.dateFormatter.string(from: date))
    }
    func test_numberOfSections_IsTwo(){
        var doneItem = ToDoItem(title: "Dummy")
        doneItem.done = true
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "Dummy 2"), doneItem])
        let sectionCount = sut?.tableView.numberOfSections
        XCTAssertEqual(sectionCount, 2)
    }
    
    func test_didSelectCellAt_ShouldCallDelegate() throws {
        let delegateMock = ToDoListViewControllerProtocolMock()
        sut!.delegate = delegateMock
        let toDoItem = ToDoItem(title: "Dummy")
        toDoItemStoreMock.itemPublisher.send([toDoItem])
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    
        XCTAssertEqual(delegateMock.selectToDoItemReceivedArgs!.item, toDoItem)
    }
    
    func test_navigationBarButton_shouldPressDelegate() throws {
        let delegateMock = ToDoListViewControllerProtocolMock()
        sut!.delegate = delegateMock
        let addButton = sut?.navigationItem.rightBarButtonItem
        let target = try XCTUnwrap(addButton?.target)
        let action = try XCTUnwrap(addButton?.action)
        _ = target.perform(action, with: addButton)
        XCTAssertEqual(delegateMock.addToDoItemCallCount, 1)
    }
    
    func test_dateFormatter_isNotNone(){
        XCTAssertNotEqual(sut?.dateFormatter.dateStyle, DateFormatter.Style.none)
    }
    
    func test_didSelectCell_shouldShowDelegate() throws
    {
        let delegateMock = ToDoListViewControllerProtocolMock()
        sut?.delegate = delegateMock
        var doneItem = ToDoItem(title: "Done Item")
        doneItem.done = true
        let toDoItem = ToDoItem(title: "Item")
        toDoItemStoreMock.itemPublisher.send([doneItem, toDoItem])
        
        let tableView = try XCTUnwrap(sut?.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.delegate?.tableView?(
            tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(delegateMock.selectToDoItemReceivedArgs?.item, toDoItem)
    }
    
}
