//
//  ViewController.swift
//  Test app
//
//  Created by Anton on 2/10/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    
    @IBOutlet weak var dimensionsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraButton(_ sender: Any) {
        
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = false
        camera.delegate = self
        present(camera, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else{
            print("Image not found")
            return
        }
        //Printing image dimensions in the terminal
        print(image.size)
        
        dimensionsLabel.text = "Size: \(String(format:"%.0f" ,image.size.width)) x  \(String(format: "%0.f", image.size.height))"
        
    }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        
    }
    
    
    

}

