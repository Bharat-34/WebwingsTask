//
//  ProfileViewController.swift
//  WebwinTask
//
//  Created by Bharat on 03/11/20.
//

import UIKit
import MRCountryPicker
import CoreLocation

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MRCountryPickerDelegate,CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var countryName: UITextField!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var address: UITextField!
    
    
    let locationManager = CLLocationManager()
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = #colorLiteral(red: 0.2361930609, green: 0.2579806745, blue: 0.2835594118, alpha: 1)
        
        countryView.layer.borderWidth = 1
        countryView.layer.borderColor = #colorLiteral(red: 0.2361930609, green: 0.2579806745, blue: 0.2835594118, alpha: 1)
        
        self.imagePicker.delegate = self
        countryPicker.countryPickerDelegate = self
        
        countryPicker.setCountryByName("India")
        
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(userImageTap))
        self.userImage.addGestureRecognizer(imageTapGesture)
        
        let textTapGes = UITapGestureRecognizer(target: self, action: #selector(textTaped))
        self.countryName.addGestureRecognizer(textTapGes)
    }
    
    
    @objc func userImageTap() {
        
        let alertController = UIAlertController(title: "Upload Image", message: "From Camera or Gallery", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            
            self.openCamersMethod()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func textTaped() {
        countryPicker.isHidden = false
    }
    
    func openCamersMethod()  {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            let alertController = UIAlertController(title: "Sorry", message: "Simulator Can't open Camera", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func openGallery()  {
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let imagePicked = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            self.userImage.contentMode = .scaleAspectFill
            self.userImage.image = imagePicked
            
        } else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            self.userImage.image = img
            self.userImage.contentMode = .scaleAspectFill
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Country pickker datasource method:-
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        self.countryName.text = name
        self.countryImage.image = flag
        
        if self.countryName.text == name {
            countryPicker.isHidden = true
        }
    }
    
    
    @IBAction func addressFetch(_ sender: UIButton) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    // Location Manager dataSource mathods:-
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
            
            let address = "\(kk!),\(kkk!),\(postalCode!),\(locality!),\(administrativeArea!),\(country!)"
            self.address.text = address
            
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error while updating location " + error.localizedDescription)
        }
        
    }
    
    
    
    
}
