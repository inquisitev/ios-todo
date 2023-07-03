//
//  TodoItemTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/2/23.
//

import XCTest
import CoreLocation
@testable import ToDo

final class TodoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_takes_title(){
        _ = ToDoItem(title: "Dummy")
    }
    
    func test_init_takes_titleAndDescription(){
        _ = ToDoItem(title: "Dummy", itemDescription: "Description")
    }
    
    func test_whenTitleGiven_titleIsSet(){
        let expectedTitle = "Dummy"
        let item = ToDoItem(title: expectedTitle)
        let actualTitle = item.title
        XCTAssertEqual(expectedTitle, actualTitle, "Expected title to be \(expectedTitle), but it actually was \(actualTitle)")
    }
    
    func test_whenDescriptionGiven_descriptionIsSet() throws {
        let expectedDescription = "a description."
        let item = ToDoItem(title: "Dummy", itemDescription: "a description.")
        XCTAssertNotNil(item.description, "Expected that description is not nil")
        let actualDescription = try XCTUnwrap(item.description)!
        XCTAssertEqual(expectedDescription, actualDescription, "Expected description to be \(expectedDescription), but it actually was \(actualDescription)")
    }
    
    func test_init_takesTimeStamp(){
        let timeStamp: TimeInterval = 42.0
        _ = ToDoItem(title: "Dummy", timeStamp: timeStamp)
    }
    
    func test_whenGivenTimeStamp_timeStampIsSet() throws{
        let timeStamp: TimeInterval = 42.0
        let item = ToDoItem(title: "Dummy", timeStamp: timeStamp)
        XCTAssertNotNil(item.timeStamp)
        let actualTimeStamp = try XCTUnwrap(item.timeStamp)
        XCTAssertEqual(actualTimeStamp, timeStamp, accuracy: 0.000_001, "Expected timestamp to be \(timeStamp),  but it was \(actualTimeStamp)")
    }
    
    func test_init_takesLocation(){
        let location = Location(name: "Title")
        _ = ToDoItem(title: "Dummy", location: location)
    }
    
    func test_whenLocationProvided_locationIsSet() throws {
        let expectedLocation = Location(name: "Title")
        let item = ToDoItem(title: "Dummy", location: expectedLocation)
        _ = try XCTUnwrap(item.location)
    }
    
    func test_item_equal_to_itself(){
        let item = ToDoItem(title: "Dummy")
        XCTAssertEqual(item, item)
    }
    
    func test_item_notEqualToDifferentItem(){
        let firstItem = ToDoItem(title: "Dummy")
        let secondItem = ToDoItem(title: "Smarty")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func test_itemWithDescription_EqualToItself(){
        let item = ToDoItem(title: "Dummy", itemDescription: "description")
        XCTAssertEqual(item, item)
    }
    
    func test_itemsWithDifferentDescription_NotEqual(){
        let firstItem = ToDoItem(title: "Dummy", itemDescription: "First Description")
        let secondItem = ToDoItem(title: "Dummy", itemDescription: "Second Description")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func test_itemWithTimeStamp_EqualToItself(){
        let item = ToDoItem(title: "Dummy", timeStamp: TimeInterval(32.0))
        XCTAssertEqual(item, item)
    }
    
    func test_itemsWithDifferentTimeStamp_NotEqual(){
        let firstItem = ToDoItem(title: "Dummy", timeStamp: TimeInterval(35.0))
        let secondItem = ToDoItem(title: "Dummy", timeStamp: TimeInterval(32.0))
        XCTAssertNotEqual(firstItem, secondItem)
    }   
    
    
    func test_itemWithLocation_EqualToItself(){
        let item = ToDoItem(title: "Dummy", timeStamp: TimeInterval(32.0))
        XCTAssertEqual(item, item)
    }
    
    func test_itemsWithDifferentLocation_NotEqual(){
        let firstItem = ToDoItem(title: "Dummy", location: Location(name: "Home", coordinate: Coordinate(latitude: 1, longitude: 2)))
        let secondItem = ToDoItem(title: "Dummy", location: Location(name: "Home", coordinate: Coordinate(latitude: 4, longitude: 3)))
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
}
