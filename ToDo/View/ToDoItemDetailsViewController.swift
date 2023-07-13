//
//  ToDoItemDetailsViewController.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/8/23.
//

import UIKit
import MapKit

class ToDoItemDetailsViewController: UIViewController {
    
    var toDoItemStore: ToDoItemStoreProtocol!
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var button: UIButton!
    var toDoItem: ToDoItem? {
        didSet{
            titleLabel.text = toDoItem?.title
            descriptionLabel.text = toDoItem?.description
            
            if let description = toDoItem?.description{
                descriptionLabel.text = description
            }
            
            if let location = toDoItem?.location{
                
                locationLabel.text = location.name
                if let coordinate = location.coordinate{
                    
                    mapView.setCenter(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), animated: false)
                }
            }
            
            if let timeStamp = toDoItem?.timeStamp{
                let date = Date(timeIntervalSince1970: timeStamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
            
            button.isEnabled = (toDoItem != nil)
        }
    }
    
    @IBAction func checkItem(_ sender: UIButton) {
        if let item = toDoItem{
            toDoItemStore?.check(item)
        }
    }
}
