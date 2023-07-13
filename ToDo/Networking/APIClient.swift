//
//  APIClient.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/8/23.
//

import Foundation
import CoreLocation

protocol URLSessionProtocol{
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol{}

protocol APIClientProtocol{
    func coordinate(for address: String, completion: @escaping (Coordinate?) -> Void)
}

protocol GeoCoderProtocol{
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeoCoderProtocol{
    
}


class APIClient: APIClientProtocol{
    
    var geoCoder: GeoCoderProtocol = CLGeocoder()
    lazy var session: URLSessionProtocol = URLSession.shared
    func coordinate(for address: String, completion: @escaping (Coordinate?) -> Void){
        geoCoder.geocodeAddressString(address) { placemark, error in
            guard let clCoordinate = placemark?.first?.location?.coordinate
            else{
                completion(nil)
                return
            }
            
            let coordinate = Coordinate(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
            completion(coordinate)
        }
    }
    
    func toDoItems() async throws -> [ToDoItem]{
        guard let url = URL(string: "http:/toodoo.app/items")
        else{
            return []
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request, delegate: nil)
        let items = try JSONDecoder().decode([ToDoItem].self, from: data)
        return items
    }
}
