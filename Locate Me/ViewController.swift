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
        
        latLabel.text    = "Latitude : " + String(userLocation.coordinate.latitude)
        lonLabel.text    = "Longitude: " + String(userLocation.coordinate.longitude)
        altLabel.text    = "Altitude : " + String(userLocation.altitude)
        courseLabel.text = "Course   : " + String(userLocation.course)
        speedLabel.text  = "Speed    : " + String(userLocation.speed) + " mps"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
              //  print(self.getAddress(pm))
            //    print(pm.addressDictionary<"City">)
                let address = self.getAddress(pm)
                print(address)
                self.addressLabel.text = address
            }else {
                print("Problem with the data received from geocoder")
                self.addressLabel.text = "No address found"
            }
            
        }
        
        
 
        
    }
    
    func getAddress(place: CLPlacemark) -> String{
   //     print("start/n/n")
    //    print(place)
    //    print("end/n/n")
      //  print((place.addressDictionary?["formattedAddressLine"]![0]? as? String)! + "/n/n/n/")
      //  print(place.addressDictionary?["FormattedAddressLines"]?[0] as? String)
        var address = ""
        //magic number to be erased. 3 = max val for given dictionary
        for  i in 0..<3{
            //I am force unwrapping the string. it beheaves as expecte but is NOT DESIRED. TODO: Find a better solution
            address += String(UTF8String: (place.addressDictionary?["FormattedAddressLines"]?[i] as? String)!)!
            if i != 2{
                address += "\n"
            }
        }
        return address
  }


}

