//
//  ViewController.swift
//  Test app
//
//  Created by Anton on 2/10/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        locationLabel.text = "Location: \(locValue.latitude), \(locValue.longitude)"
    }
    
    //camera button
    @IBAction func cameraButton(_ sender: Any) {
        
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = false
        camera.delegate = self
        present(camera, animated: true)
    }
    
    //a pop up message after sending the dimensions
    func alert()
    {
        let alertController = UIAlertController(title: "Test app", message:
            "The dimensions have been sent", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    
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
    //send button
    @IBAction func sendButton(_ sender: Any) {
     
        let information = Dimensions(dimensions: dimensionsLabel.text!, location: locationLabel.text!)
        
        let postRequest = APIRequest()
        
        postRequest.save(information, completion: {result in
            switch result {
            case .success(let dimensions):
                print("The following dimensions have been sent: \(dimensions)")
            case .failure(let error):
                print("An error occured \(error)")
            }
        })
        alert()
    }

}

