//
//  Trips+CoreDataProperties.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//
//

import Foundation
import CoreData


extension Trips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trips> {
        return NSFetchRequest<Trips>(entityName: "Trips")
    }

    @NSManaged public var destination: String?
    @NSManaged public var rawTravelouges: NSOrderedSet?

}

// MARK: Generated accessors for rawTravelouges
extension Trips {

    @objc(insertObject:inRawTravelougesAtIndex:)
    @NSManaged public func insertIntoRawTravelouges(_ value: Travelouge, at idx: Int)

    @objc(removeObjectFromRawTravelougesAtIndex:)
    @NSManaged public func removeFromRawTravelouges(at idx: Int)

    @objc(insertRawTravelouges:atIndexes:)
    @NSManaged public func insertIntoRawTravelouges(_ values: [Travelouge], at indexes: NSIndexSet)

    @objc(removeRawTravelougesAtIndexes:)
    @NSManaged public func removeFromRawTravelouges(at indexes: NSIndexSet)

    @objc(replaceObjectInRawTravelougesAtIndex:withObject:)
    @NSManaged public func replaceRawTravelouges(at idx: Int, with value: Travelouge)

    @objc(replaceRawTravelougesAtIndexes:withRawTravelouges:)
    @NSManaged public func replaceRawTravelouges(at indexes: NSIndexSet, with values: [Travelouge])

    @objc(addRawTravelougesObject:)
    @NSManaged public func addToRawTravelouges(_ value: Travelouge)

    @objc(removeRawTravelougesObject:)
    @NSManaged public func removeFromRawTravelouges(_ value: Travelouge)

    @objc(addRawTravelouges:)
    @NSManaged public func addToRawTravelouges(_ values: NSOrderedSet)

    @objc(removeRawTravelouges:)
    @NSManaged public func removeFromRawTravelouges(_ values: NSOrderedSet)

}
