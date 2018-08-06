//
//  AddCurrentlyViewController.swift
//  DemoWeather
//
//  Created by Nguyen Nam on 8/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import MapKit

class AddCurrentlyViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate , UITextFieldDelegate{
    
    
    var DARK_SKY_API = "https://api.darksky.net/forecast/45842c0189dae30871b80b9556bbba61/"
    
    var currently:Currently?
    var location:CLLocationManager?
    var navitionButtonSave:UIBarButtonItem?
    var currentLocation:CLLocation?
    var urlString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Currently"
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navitionButtonSave = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(unwindToMain))
        self.navigationItem.rightBarButtonItem = navitionButtonSave
        // Do any additional setup after loading the view.
        setupViews()
        location = CLLocationManager()
        location?.delegate = self
        location?.desiredAccuracy = kCLLocationAccuracyBest
        
        location?.requestAlwaysAuthorization()
        location?.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async {
            self.location?.startUpdatingLocation()
        }
        mapKit.delegate = self
        mapKit.showsUserLocation = true
        mapKit.showsBuildings = true
        mapKit.showsTraffic = true
        updateSaveButtonState()
        
        countryTextField.delegate = self
        cityTextField.delegate = self
        
    }
    
    
    @objc private func unwindToMain(){
        pinCurrently()
    }
    
    private func getCurrently(_ location:CLLocation){
        urlString = DARK_SKY_API + "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlString)!), completionHandler: { (data, response, error) in
                        DispatchQueue.main.async {
                            if let jsonData = data{
                                let feed = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary
                                self.currently = Currently()
                                let time = feed?.value(forKeyPath: "currently.time") as? Int
                                let summary = feed?.value(forKeyPath: "currently.summary") as? String
                                let icon = feed?.value(forKeyPath: "currently.icon") as? String
                                let temperature = feed?.value(forKeyPath: "currently.temperature") as? Double
                                let humidity = feed?.value(forKeyPath: "currently.humidity") as? Double
                                let windSpeed = feed?.value(forKeyPath: "currently.windSpeed") as? Double
                                let cloudCover = feed?.value(forKeyPath: "currently.cloudCover") as? Double
            
            
                                let address = Address()
                                address.city = self.cityTextField.text
                                address.country = self.countryTextField.text
            
                                self.currently?.address = address
                                self.currently?.time = time
                                self.currently?.summary = summary
                                self.currently?.icon = icon
                                self.currently?.temperature = temperature
                                self.currently?.humidity = humidity
                                self.currently?.windSpeed = windSpeed
                                self.currently?.cloudCover = cloudCover
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                        
                    }).resume()
                    

    }
    
    @objc private func pinCurrently(){
        let address = "\(cityTextField.text!) , \(countryTextField.text!)"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            let placemark = placemarks?.first
            let pinAnnotation = MKPointAnnotation()
            pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: (placemark?.location?.coordinate.latitude)!, longitude: (placemark?.location?.coordinate.longitude)!)
            pinAnnotation.title = placemark?.name
            self.mapKit.addAnnotation(pinAnnotation)
            self.displayLocationInfo(placemark)
        }
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance((location?.coordinate)!, 500 * 2.0, 500 * 2.0)
        mapKit.setRegion(region, animated: true)
    }
    
    
    private func displayLocationInfo(_ placeMark:CLPlacemark?){
        self.location?.stopUpdatingLocation()
        if placeMark != nil{
            cityTextField.text = placeMark?.name ?? " "
            countryTextField.text = placeMark?.country ?? " "
            let location = placeMark?.location
            let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance((location?.coordinate)!, 500 * 2.0, 500 * 2.0)
            mapKit.setRegion(region, animated: true)
            currentLocation = location
            print(currentLocation)
            getCurrently(currentLocation!)
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    
    private func updateSaveButtonState(){
        if (cityTextField.text?.isEmpty)! || (countryTextField.text?.isEmpty)! {
            navitionButtonSave?.isEnabled = false
        }
        else{
            navitionButtonSave?.isEnabled = true
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        return true
    }
    
    
    private func setupViews(){
        self.view.addSubview(cityTextField)
        self.view.addSubview(countryTextField)
        self.view.addSubview(mapKit)
//        mapKit.addSubview(searchButton)
//        mapKit.addContraintWithFormat(stringFormat: "H:[v0(44)]-10-|", views: searchButton)
//        mapKit.addContraintWithFormat(stringFormat: "V:[v0(44)]-10-|", views: searchButton)
        view.addContraintWithFormat(stringFormat: "H:|-20-[v0]-20-|", views: cityTextField)
        view.addContraintWithFormat(stringFormat: "H:|[v0]|", views: mapKit)
        view.addContraintWithFormat(stringFormat: "V:|-84-[v0]-20-[v1]-10-[v2]|", views:cityTextField,countryTextField,mapKit)
        view.addContraintWithFormat(stringFormat: "H:|-20-[v0]-20-|", views: countryTextField)
    }
    
//    let searchButton:UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor.white
//        button.setImage(UIImage(named: "cursor"), for: .normal)
//        button.addTarget(self, action: #selector(pinCurrently), for: .touchUpInside)
//        return button
//    }()
    
    
    let mapKit:MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    let cityTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your city"
        textField.textAlignment = .center
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let countryTextField:UITextField  = {
        let textField = UITextField()
        textField.placeholder = "Your country"
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        return textField
    }()
    
}

extension UIView{
    public func addContraintWithFormat(stringFormat:String, views:UIView...){
        var viewDictionary = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: stringFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
