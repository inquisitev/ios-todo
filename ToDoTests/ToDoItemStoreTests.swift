//
//  ToDoItemStoreTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/3/23.
//

import XCTest
import Combine
@testable import ToDo

final class ToDoItemStoreTests: XCTestCase{
    var sut: ToDoItemStore!
    
    override func setUpWithError() throws {
        sut = ToDoItemStore(fileName: "dummy_store")
    }
    override func tearDownWithError() throws {
        sut = nil
        
        let url = FileManager.default.documentsURL(name: "dummy_store")
        try? FileManager.default.removeItem(at: url)
        
    }
    func test_add_shouldPublishChange() throws {
        let toDoItem = ToDoItem(title: "Dummy")
        let receivedItems = try wait(for: sut.itemPublisher){
            sut.add(toDoItem)
        }
        XCTAssertEqual(receivedItems, [toDoItem])
    }
    
    func test_check_shouldPublishChangeInDoneItems() throws {
        let todoItem = ToDoItem(title: "Dummy")
        sut.add(todoItem)
        sut.add(ToDoItem(title: "Dummy 2"))
        let receivedItems = try wait(for: sut.itemPublisher){
            sut.check(todoItem)
        }
        
        let doneItems = receivedItems.filter({$0.done})
        XCTAssertEqual(doneItems, [todoItem])
    }
    
    func test_init_shouldLoadPreviousToDoItems(){
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "Wait for piublisher in \(#file)")
        let todoItem = ToDoItem(title: "Dummy")
        sut1?.add(todoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher.sink{ value in
            result = value
            publisherExpectation.fulfill()
        }
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [todoItem])
        
    }
    
    
    
    func test_init_whenItemIsChecked (){
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "Wait for piublisher in \(#file)")
        let todoItem = ToDoItem(title: "Dummy")
        sut1?.add(todoItem)
        sut1?.check(todoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher.sink{ value in
            result = value
            publisherExpectation.fulfill()
        }
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [todoItem])
        
    }
}


extension XCTestCase{
    func wait<T: Publisher>(
        for publisher: T,
        afterChange change: () -> Void,
        file: StaticString = #file,
        line: UInt = #line)
        throws -> T.Output where T.Failure == Never{
            let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
            
            var result: T.Output?
            let token = publisher
                .dropFirst()
                .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
            
            change()
            wait(for: [publisherExpectation], timeout: 1 )
            token.cancel()
            
            let unwrappedResult = try XCTUnwrap(result, "Publisher did not publish any value", file: file, line: line)
            return unwrappedResult
        }
}
