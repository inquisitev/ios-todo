//
//  APIClientMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/8/23.
//

import Foundation
@testable import ToDo

class APIClientMock: APIClientProtocol{
    var coordinateAddress: String?
    var coordinateReturnValue: Coordinate?
    
    
    func coordinate(for address: String, completion: (Coordinate?) -> Void){
        coordinateAddress = address
        completion(coordinateReturnValue)
    }
    
}
