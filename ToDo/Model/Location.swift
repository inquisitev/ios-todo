//
//  Location.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation
struct Location: Equatable, Codable{
    
    init(name: String, coordinate: Coordinate? = nil){
        self.name = name
        self.coordinate = coordinate
    }
    
    let name: String
    let coordinate: Coordinate?
}
