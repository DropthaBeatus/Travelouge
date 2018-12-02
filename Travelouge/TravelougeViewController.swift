//
//  TravelougeViewController.swift
//  Travelouge
//
//  Created by Liam Flaherty on 11/20/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit
import CoreData

class TravelougeViewController: UIViewController {

    @IBOutlet weak var travelText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func Save(_ sender: Any) {
        let trip = Trips(destination: travelText.text!)
        do{
            try trip?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
        }catch{
            print("Could not save destination Category")
        }
    }
    
}
