//
//  ViewController.swift
//  DemoGoogleMaps
//
//  Created by Nguyen Nam on 8/17/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView:GMSMapView!
    var locationManager:CLLocationManager!
    
    var placesClient:GMSPlacesClient!
    let zoomLevel:Float = 15.0
    //    let placeViewController:PlacesViewController!
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSMarker] = []
    
    // The currently selected place.
    var selectedMarker: GMSMarker?
    
    var listMark:[GMSMarker] = []
    //    var location:CLLocation!
    
    
    
    var i = 0
    let defatulLocation = CLLocation(latitude: 20.9970823, longitude: 105.8486906)
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()
        // map view
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: defatulLocation.coordinate.latitude, longitude: defatulLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame:view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.mapType = GMSMapViewType.normal
        view.addSubview(mapView)
        mapView.isHidden = true
        listLikelyPlaces(location: defatulLocation)
        mapView!.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedMarker != nil{
            mapView.animate(toLocation: (selectedMarker?.position)!)
        }
    }
    // Populate the array with the list of likely place
    
    func listLikelyPlaces(location:CLLocation) {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        let marker:GMSMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        marker.title = "New Location \(i)"
        marker.map = mapView
        //        marker.icon = GMSMarker.markerImage(with: UIColor.blue)
        listMark.append(marker)
        i += 1
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "segueToSelect":
            let placeViewController = segue.destination as! PlacesViewController
            placeViewController.listMarker = listMark
        default:
            break
        }
    }
    
}

extension ViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation  = locations.last!
        print("\(currentLocation)")
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden{
            mapView.isHidden = false
            mapView.camera = camera
        }else{
            mapView.animate(to: camera)
        }
        listLikelyPlaces(location: currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted")
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            print("Locaton status is OK")
        case .denied:
            print("User denied access to location")
        default:
            break
        }
    }
}
extension ViewController : GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        let infoMarker = GMSMarker()
        let title = name.replacingOccurrences(of: "\n", with: " ", options: [], range: nil)
        //        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = title
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.isMyLocationEnabled = true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapView.isMyLocationEnabled = true
        mapView.selectedMarker  = nil
        return true
    }
}





