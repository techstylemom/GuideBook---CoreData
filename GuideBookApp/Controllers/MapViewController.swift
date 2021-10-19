//
//  MapViewController.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var place:Place?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if place != nil {
            
            // Create CLLocation2D
            let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            
            let pin = MKPointAnnotation()
            pin.coordinate = location
            
            mapView.addAnnotation(pin)
            
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
