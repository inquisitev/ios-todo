//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/9/23.
//

import Foundation
import XCTest
import Intents
import Contacts
@testable import ToDo

class APIClientTests: XCTestCase{
    var sut: APIClient!
    
    override func setUpWithError() throws {
        sut = APIClient()
    }
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func test_coordinate_usesAddress(){
        let geoCoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geoCoderMock
        
        let location = CLLocation(latitude: 1, longitude: 2)
        let placeMark = CLPlacemark(location: location, name: nil, postalAddress: nil)
        
        let expectedAddress = "Dummy Address"
        sut.coordinate(for:expectedAddress){
            _ in
        }
        
        geoCoderMock.completionHandler?([placeMark], nil)
        XCTAssertEqual(geoCoderMock.geocodeAddressString, expectedAddress)
    }
    
    func test_coordinate_fetchesCoordinate(){
        let geoCoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geoCoderMock
        
        let location = CLLocation(latitude: 1, longitude: 2)
        let placeMark = CLPlacemark(location: location, name: nil, postalAddress: nil)
        
        let expectedAddress = "Dummy Address"
        var result: Coordinate?
        sut.coordinate(for:expectedAddress){
            coordinate in
            result = coordinate
        }
        
        geoCoderMock.completionHandler?([placeMark], nil)
        XCTAssertEqual(result?.latitude, location.coordinate.latitude)
        XCTAssertEqual(result?.longitude, location.coordinate.longitude)
    }
    
    func test_toDoItems_shouldFetchToDoItem() async throws{
        
        let url = try XCTUnwrap(URL(string: "http:/toodoo.app/items"))
        let urlSessionMock = URLSessionProtocolMock()
        let expected = [ToDoItem(title: "dummy")]
        
        urlSessionMock.dataForDelegateReturnValue = (
            try JSONEncoder().encode(expected),
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        )
        sut.session = urlSessionMock
        let items = try await sut.toDoItems()
        XCTAssertEqual(items, expected)
        XCTAssertEqual(url, urlSessionMock.dataForDelegateRequest?.url)
    }
    
    
    func test_toDoItems_whenError_ThrowError() async throws{
        
        let urlSessionMock = URLSessionProtocolMock()
        let expected = NSError(domain: "", code: 1234)
        urlSessionMock.dataForDelegateError = expected
        sut.session = urlSessionMock
        
        do{
            _ = try await sut.toDoItems()
            XCTFail()
        }
        catch{
            let nsError = try XCTUnwrap(error as NSError)
            XCTAssertEqual(nsError, expected)
        }
    }
    
    func test_toDoItems_whenJsonIsWrong() async throws{
        
        let url = try XCTUnwrap(URL(string: "foo"))
        let urlSessionMock = URLSessionProtocolMock()
        
        urlSessionMock.dataForDelegateReturnValue = (
            try JSONEncoder().encode("dummy"),
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        )
        sut.session = urlSessionMock
        do{
            _ = try await sut.toDoItems()
            XCTFail()
        }
        catch{
            XCTAssertTrue(error is Swift.DecodingError)
        }
    }
    
    
}

