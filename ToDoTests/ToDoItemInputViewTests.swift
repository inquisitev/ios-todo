//
//  ToDoItemInputViewTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/8/23.
//

import Foundation
@testable import ToDo
import ViewInspector
import XCTest

class ToDoItemInputViewTests: XCTestCase{
    
    var sut: ToDoItemInputView!
    var toDoItemData: ToDoItemData!
    var apiClientMock: APIClientMock!
    
    override func setUpWithError() throws {
        toDoItemData = ToDoItemData()
        apiClientMock = APIClientMock()
        sut = ToDoItemInputView(data: toDoItemData, apiClient: apiClientMock)
    }
    
    override func tearDownWithError() throws {
        toDoItemData = nil
        sut = nil
        apiClientMock = nil
    }
    
    func test_titleInput_shouldSetValueData()throws {
        let expected = "Title"
        try sut.inspect().find(ViewType.TextField.self)
            .setInput(expected)
        let input = toDoItemData.title
        XCTAssertEqual(expected, input)
    }
    
    func test_whenWithoutDate_DontShowDatePicker() throws{
        XCTAssertThrowsError(try sut.inspect().find(ViewType.DatePicker.self))
    }
    
    func test_form_hasASaveButton() throws{
        XCTAssertNoThrow(try sut.inspect()
            .find(ViewType.Button.self, where: { view in
                let label = try view.labelView().text().string()
                return label == "Save"
            }))
    }
    
    func test_saveButton_shouldFetchCoordinates() throws {
        toDoItemData.title = "Dummy"
        let expected = "dummy address"
        toDoItemData.address = expected
        try tapButtonWith(labelText: "Save")
        
        XCTAssertEqual(apiClientMock?.coordinateAddress, expected)
    }
    
    func tapButtonWith(labelText: String) throws{
        try sut.inspect().find(ViewType.Button.self, where: { view in
            let label = try view.labelView().text().string()
            return label == labelText
        }).tap()
    }
    
    func test_saveButton_doesNotFetchWhenMissingAddress() throws {
        toDoItemData.title = "Dummy"
        try tapButtonWith(labelText: "Save")
        
        XCTAssertNil(apiClientMock.coordinateAddress)
    }
    
    func test_saveButton_shouldCallDelegate() throws {
        toDoItemData.title = "Dummy"
        toDoItemData.address = "dummy address"
        apiClientMock.coordinateReturnValue = Coordinate(latitude: 2, longitude: 2)
        let delegateMock = ToDoItemInputViewDelegateMock()
        sut.delegate = delegateMock
        try tapButtonWith(labelText: "Save")
        
        XCTAssertEqual(delegateMock.item?.title, "Dummy")
        XCTAssertEqual(delegateMock.coordinate?.latitude, 2)
        XCTAssertEqual(delegateMock.coordinate?.longitude, 2)
    }
    
    
    func test_saveButton_shouldCallDelegate_evenWithoutAddress() throws {
        toDoItemData.title = "Dummy"
        let delegateMock = ToDoItemInputViewDelegateMock()
        sut.delegate = delegateMock
        try tapButtonWith(labelText: "Save")
        
        XCTAssertEqual(delegateMock.item?.title, "Dummy")
    }
    
}
