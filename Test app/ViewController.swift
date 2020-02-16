//
//  ViewController.swift
//  Test app
//
//  Created by Anton on 2/10/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import UIKit
import MapKit

/**
 
# Test app
 
 The app that sends image dimensions and location on the server in JSON format
 
## Labels

 1. dimensionLabel
 2. locationLabel

## Functions

### cameraButton

Opens the camera: `@IBAction func cameraButton(_ sender: Any)`

### alert

Pop up message:  `func alert()`

### imagePickerController

````
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
```

Tells the delegate that the user picked a still image or movie.

### sendButton

Sends the data: `@IBAction func sendButton(_ sender: Any)`
 
 */


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {

    ///Camera UIButton
    @IBOutlet weak var camera: UIButton!
    
    ///Send UIButton
    
    @IBOutlet weak var send: UIButton!
    
    ///UILabel for image dimensions
    
    @IBOutlet weak var dimensionsLabel: UILabel!
    
    ///UILabel for location
    
    @IBOutlet weak var locationLabel: UILabel!
    
    /// The variable for the object that we use to start and stop the delivery of location-related events to our app.
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    /// Function that tells the delegate that new location data is available.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        locationLabel.text = "Location \(locValue.latitude), \(locValue.longitude)"
    }
    
    ///Function of  a camera button
    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            let camera = UIImagePickerController()
            camera.sourceType = .camera
            camera.allowsEditing = false
            camera.delegate = self
            present(camera, animated: true)
        }
        else {
            noCamera()
        }
    }
    ///Function for camera in simulator that gives a pop up message "This device has no camera"
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "This device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,
            animated: true,
            completion: nil)
    }
    
    ///Function of a pop up message after sending the dimensions
    func alert()
    {
        let alertController = UIAlertController(title: "Test app", message:
            "The data have been sent", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    ///Function that  tells the delegate that the user picked a still image or movie.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else{
            print("Image not found")
            return
        }
        
        //Printing image dimensions in the terminal
        print(image.size)
        
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        
        // Printing image dimensions to the main screen
        dimensionsLabel.text = "Size: \(String(format:"%.0f" ,imageWidth)) x \(String(format: "%0.f", imageHeight))"
        
    }
    ///Function of send button
    @IBAction func sendButton(_ sender: Any) {
     
        let information = Dimensions(dimensions: dimensionsLabel.text!, location: locationLabel.text!)
        
        let postRequest = APIRequest()
        
        postRequest.save(information, completion: {result in
            switch result {
            case .success(let info):
                print("The following data have been sent: \(info)")
            case .failure(let error):
                print("An error occured \(error)")
            }
        })
        alert()
    }

}

