//
//  user-health.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

class Userhealth: NSManagedObject {
    @NSManaged var dateTime: NSDate
    @NSManaged var bloodSugarReading: Int
    @NSManaged var estCarbCount: Double
    @NSManaged var insulinInTake: Double
    @NSManaged var notes: String
    
    
    class func createInManagedObjectContextHealth(moc: NSManagedObjectContext, dT: NSDate, BSreading: Int, estCC: Double, II: Double, note: String) -> Userhealth {
        let newEntry = NSEntityDescription.insertNewObjectForEntityForName("Userhealth", inManagedObjectContext: moc) as Userhealth
       // newEntry.userid = user
        newEntry.dateTime = dT
        newEntry.bloodSugarReading = BSreading
        newEntry.estCarbCount = estCC
        newEntry.insulinInTake = II
        newEntry.notes = note
        return newEntry
    }
}