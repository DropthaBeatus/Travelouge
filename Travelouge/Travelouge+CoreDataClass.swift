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
    
    //need to convert UIimage to raw data
    convenience init?(title: String?, textContent: String?, image : UIImage, fuaxDate : Date){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let title = title, title != "" else {
                return nil
        }
        self.init(entity: Travelouge.entity(), insertInto: managedContext)
        self.title = title
        self.textContent = textContent
        date = fuaxDate
        
    }
    
    func update(title: String?, textContent: String?, image : UIImage, fuaxDate : Date){
        self.title = title
        self.textContent = textContent
        date = fuaxDate
        
    }
    
}
