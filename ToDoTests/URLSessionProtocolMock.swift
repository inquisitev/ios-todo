//
//  URLSessionProtocolMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/10/23.
//

import Foundation
import XCTest
@testable import ToDo

class URLSessionProtocolMock: URLSessionProtocol{
    var dataForDelegateReturnValue: (Data, URLResponse)?
    var dataForDelegateRequest: URLRequest?
    var dataForDelegateError: Error?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let error = dataForDelegateError{
            throw error
        }
        guard let dataForDelegateReturnValue = dataForDelegateReturnValue
        else{
            fatalError()
        }
        dataForDelegateRequest = request
        return dataForDelegateReturnValue
    }
    
    
}
