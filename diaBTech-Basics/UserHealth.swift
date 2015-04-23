//
//  user-health.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

@objc(UserHealth)
class UserHealth: NSManagedObject {
    @NSManaged var dateTime: NSDate
    @NSManaged var bloodSugarReading: Int16
    @NSManaged var estCarbCount: Double
    @NSManaged var insulinInTake: Double
    @NSManaged var notes: String
    

    class func createInManagedObjectContextHealth(moc: NSManagedObjectContext, dT: NSDate, BSreading: Int, estCC: Double, II: Double, note: String) -> UserHealth {
        let entity = NSEntityDescription.entityForName("UserHealth", inManagedObjectContext: moc)
        //let card = Card(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        let newEntry = UserHealth(entity: entity!, insertIntoManagedObjectContext: moc)
        //let newEntry = NSEntityDescription.insertNewObjectForEntityForName("UserHealth",  inManagedObjectContext: moc) as UserHealth
       // newEntry.userid = user
        newEntry.dateTime = dT
        newEntry.bloodSugarReading = Int16(BSreading)
        newEntry.estCarbCount = estCC
        newEntry.insulinInTake = II
        newEntry.notes = note
        return newEntry
    }
}