//
//  Location.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/2/23.
//

import Foundation
import CoreLocation

struct Location{
    
    init(name: String, coordinate: CLLocation? = nil){
        self.name = name
        self.coordinate = coordinate
    }
    
    let name: String
    let coordinate: CLLocation?
}
