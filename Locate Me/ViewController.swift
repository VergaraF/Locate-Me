//
//  ViewController.swift
//  Locate Me
//
//  Created by Fabian Vergara on 2016-06-09.
//  Copyright © 2016 fvergara. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lonLabel: UILabel!
    @IBOutlet var altLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        setLabels(locations)
        
        print(locations)
    }
    
    func setLabels(locations: [CLLocation]){
        let userLocation : CLLocation = locations[0]
        
        latLabel.text = "Latitude : " + String(userLocation.coordinate.latitude)
        lonLabel.text = "Longitude: " + String(userLocation.coordinate.longitude)

        
    }


}

