//
//  APIClient.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/8/23.
//

import Foundation
protocol APIClientProtocol{
    func coordinate(for: String, completion: (Coordinate?) -> Void)
}

class APIClient: APIClientProtocol{
    
    func coordinate(for: String, completion: (Coordinate?) -> Void){
        
    }
}
