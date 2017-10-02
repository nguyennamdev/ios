//
//  ViewController.swift
//  DemoLoctation
//
//  Created by Nguyen Nam on 8/16/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController , MKMapViewDelegate ,CLLocationManagerDelegate{
    
    
    
    @IBOutlet weak var map: MKMapView!
    var lat:CLLocationDegrees!
    var lng:CLLocationDegrees!
    var location : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        location = CLLocationManager()
        location?.delegate = self
        location?.desiredAccuracy = kCLLocationAccuracyBest
        
        location?.requestWhenInUseAuthorization()
        location?.requestAlwaysAuthorization()
        
        DispatchQueue.main.async {
            self.location?.startUpdatingLocation()
        }
        
        map.delegate = self
        map.showsUserLocation = true
        createAnnotation()
        
        
        
    }
    
    // create pin ( annotation )
    func createAnnotation(){
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(21.9922396, 105.84625)
        annotation.title = "My Home"
        map.addAnnotation(annotation)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2))
        map.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = locations[0].coordinate.latitude
        lng = locations[0].coordinate.longitude
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



