//
//  ToDoItemDetailsViewControllerTest.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/8/23.
//

import Foundation
import XCTest

@testable import ToDo

class ToDoItemDetailsViewControllerTest: XCTestCase{
    var sut: ToDoItemDetailsViewController!
    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = (storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as! ToDoItemDetailsViewController)
        sut.loadViewIfNeeded()
        
    }
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func test_view_shouldHaveTitleLabel() throws {
        let subview = try XCTUnwrap(sut.titleLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDateLabel() throws {
        let subview = try XCTUnwrap(sut.dateLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveLocationLabel() throws {
        let subview = try XCTUnwrap(sut.locationLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDescriptionLabel() throws {
        let subview = try XCTUnwrap(sut.descriptionLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveMapView() throws {
        let subview = try XCTUnwrap(sut.mapView)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_hasCorrectTitle(){
        let item = ToDoItem(title: "Dummy")
        sut.toDoItem = item
        XCTAssertEqual(sut.titleLabel.text, item.title)
    }
    
    func test_view_hasCorrectDescription(){
        let item = ToDoItem(title: "Dummy", itemDescription: "Description")
        sut.toDoItem = item
        XCTAssertEqual(sut.descriptionLabel.text, item.description)
    }
    
    func test_view_hasCorrectLocation(){
        let item = ToDoItem(title: "Dummy", location: Location(name: "Home", coordinate: Coordinate(latitude: 4, longitude: 2)))
        sut.toDoItem = item
        XCTAssertEqual(sut.locationLabel.text, item.location?.name)
    }
    
    
    func test_map_hasCorrectCenter() throws {
        let item = ToDoItem(title: "Dummy", location: Location(name: "Home", coordinate: Coordinate(latitude: 4, longitude: 2)))
        sut.toDoItem = item
        let coord = try XCTUnwrap(item.location?.coordinate)
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, coord.latitude, accuracy:0.000_001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, coord.longitude, accuracy:0.000_001)
    }
    
    func test_button_IsEnabledWhenItemProvided() throws{
        let item = ToDoItem(title: "Dummy")
        sut.toDoItem = item
        XCTAssertTrue(sut.button.isEnabled)
    }
    
    func test_sendingButtonAction_shoudCheckItem() throws{
        
        let item = ToDoItem(title: "Dummy")
        sut.toDoItem = item
        let storeMock = ToDoItemStoreMock()
        sut.toDoItemStore = storeMock
        sut.button.sendActions(for: .touchUpInside)
        XCTAssertEqual(storeMock.checkLastCallArgument, item)
    }

}
