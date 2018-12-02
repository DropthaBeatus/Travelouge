//
//  Travelouge+CoreDataProperties.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//
//

import Foundation
import CoreData


extension Travelouge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Travelouge> {
        return NSFetchRequest<Travelouge>(entityName: "Travelouge")
    }

    @NSManaged public var rawData: NSData?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var textContent: String?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trips?

}
