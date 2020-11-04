//
//  ViewController.swift
//  WebwinTask
//
//  Created by Bharat on 03/11/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func findMyLocation(_ sender: UIButton) {
        locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
                
                if (error != nil) {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0]
                    self.displayLocationInfo(pm)
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
        }
        
        func displayLocationInfo(_ placemark: CLPlacemark?) {
            
            if let containsPlacemark = placemark {
                //stop updating location to save battery life
                locationManager.stopUpdatingLocation()
                let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
                let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
                let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
                let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
                let kkk = (containsPlacemark.subThoroughfare != nil) ? containsPlacemark.subThoroughfare : ""
                let kk = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""

                print(kk!)
                print(kkk!)
                print(locality!)
                print(postalCode!)
                print(administrativeArea!)
                print(country!)
                
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                  print("Error while updating location " + error.localizedDescription)
            }
            
        }

}
