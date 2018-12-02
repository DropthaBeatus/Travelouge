//
//  Trips+CoreDataClass.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trips)
public class Trips: NSManagedObject {
    var  travelouges : [Travelouge]?{
        return self.rawTravelouges?.array as? [Travelouge]
    }
    
    
    convenience init?(destination : String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        self.init(entity: Trips.entity(), insertInto: context)
        self.destination = destination
    }

}
