//
//  LogViewController.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit
import CoreData

class LogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var logEntry: UITextView!
    
    @IBOutlet weak var logTitle: UITextField!
    
    @IBOutlet weak var logDate: UIDatePicker!
    
    var travelouge : Travelouge?
    var trips : Trips?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let travelouge = travelouge{
            logEntry.text = travelouge.textContent
            logTitle.text = travelouge.title
            logDate.date = travelouge.date!
            photoView.image = travelouge.pic
            title = travelouge.title
        }
    }
    
    
    @IBAction func Save(_ sender: Any) {
        if(logTitle.text == ""){
            Alert("Missing", message :"Missing Title")
            return
        }
        if(photoView.image == nil){
            Alert("Missing", message :"Missing Image")
            return
        }
        if(logEntry.text == ""){
            Alert("Missing", message :"Missing Text Entry")
            return
        }
        if travelouge == nil {
            if let trips = trips {
                travelouge = Travelouge(title: logTitle.text, textContent: logEntry.text, image: photoView.image!, fuaxDate: logDate.date, trip: trips)
            }
        } else {
            // document exists, update existing one
            if let trips = trips {
                travelouge?.update(title: logTitle.text, textContent: logEntry.text, image: photoView.image!, fuaxDate: logDate.date, trip: trips)
            }
        }
        if let travelouge = travelouge {
            do {
                let managedContext = travelouge.managedObjectContext
                try managedContext?.save()
            } catch {
                Alert("Error", message: "Entry not saved.")
            }
        } else {
            Alert("Error", message: "Entry not saved.")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func Alert(_ alertTitle: String, message : String){
        let alertController = UIAlertController(title: alertTitle, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            Alert(alertTitle:"Error" ,"Camera not supported by this device")
            return
        }
        //sets camera for sourse type of image view
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        //sends image to image picker
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            Alert(alertTitle: "Error", "Could not open Image")
            return
        }
        photoView.image = image
        defer {
            picker.dismiss(animated: true)
        }
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
    }
    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            Alert(alertTitle: "Feature Not Available", "can't open photo library")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func Alert(alertTitle: String,_ alertMessage : String){
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func takePhoto(_ sender: Any) {
        setCamera()
    }
    
    @IBAction func openImages(_ sender: Any) {
        openPhotoLibrary()
    }
    
}
