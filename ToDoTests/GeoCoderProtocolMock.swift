//
//  GeoCoderProtocolMock.swift
//  ToDoTests
//
//  Created by Trevor  Keegan on 7/9/23.
//

import Foundation
import CoreLocation
@testable import ToDo

class GeoCoderProtocolMock: GeoCoderProtocol{
    
    var geocodeAddressString: String?
    var completionHandler: CLGeocodeCompletionHandler?
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        self.geocodeAddressString = addressString
        self.completionHandler = completionHandler
    }
    
    
}
