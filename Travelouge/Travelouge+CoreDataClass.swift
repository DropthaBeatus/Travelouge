//
//  Travelouge+CoreDataClass.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Travelouge)
public class Travelouge: NSManagedObject {

    
    var date: Date? {
        get{
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    
    var pic : UIImage?{
        get{
            return UIImage(data: rawData! as Data)
        }
        set{
            rawData = NSData( data : newValue!.pngData()!)
        }
    }
    
    //need to convert UIimage to raw data
    convenience init?(title: String?, textContent: String?, image : UIImage, fuaxDate : Date, trip : Trips){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let title = title, title != "" else {
                return nil
        }
        self.init(entity: Travelouge.entity(), insertInto: managedContext)
        self.title = title
        self.textContent = textContent
        self.trip = trip
        date = fuaxDate
        pic = image
    }
    
    func update(title: String?, textContent: String?, image : UIImage, fuaxDate : Date, trip : Trips){
        self.title = title
        self.textContent = textContent
        date = fuaxDate
        pic = image
        self.trip = trip
    }
    
}
