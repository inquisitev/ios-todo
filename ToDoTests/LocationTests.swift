//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation

import XCTest
import CoreLocation
@testable import ToDo

final class LocationTests: XCTestCase {
    func test_init_takesName(){
        _ = Location(name: "Location")
    }
    
    func test_whenNameProvided_thenNameIsSet(){
        let name: String = "Name"
        let location = Location(name: name)
        XCTAssertEqual(location.name, name)
    }
    
    func test_init_takesCoordinate(){
        let coord = CLLocation(latitude: 1, longitude: 2)
        _ = Location(name: "Location", coordinate: coord)
    }
    
    func test_whenCoordinateGiven_ThenCoordinateSet() throws{
        let coord = CLLocation(latitude: 1, longitude: 2)
        let location = Location(name: "Dummy", coordinate: coord)
        let actualCoordinate = try XCTUnwrap(location.coordinate)
        XCTAssertEqual(coord, actualCoordinate)
    }
    
}

