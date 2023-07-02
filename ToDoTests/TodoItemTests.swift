//
//  TodoItemTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/2/23.
//

import XCTest
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
    
    func test_whenDescriptionGiven_descriptionIsSet(){
        let expectedDescription = "a description."
        let item = ToDoItem(title: "Dummy", itemDescription: "a description.")
        XCTAssertNotNil(item.description, "Expected that description is not nil")
        let actualDescription = item.description!
        XCTAssertEqual(expectedDescription, actualDescription, "Expected description to be \(expectedDescription), but it actually was \(actualDescription)")
    }
    

}
