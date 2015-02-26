//
//  user-health.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

class userhealth: NSManagedObject {
    @NSManaged var userid: Int
    @NSManaged var dateTime: NSDate
    @NSManaged var bloodsugarreading: Int
    @NSManaged var estcarbcount: Double
    @NSManaged var insulinintake: Double
    @NSManaged var notes: String
    
    
    class func createInManagedObjectContextHealth(moc: NSManagedObjectContext, dT: NSDate, BSreading: Int, estCC: Double, II: Double, note: String) -> userhealth {
        let newEntry = NSEntityDescription.insertNewObjectForEntityForName("userhealth", inManagedObjectContext: moc) as userhealth
       // newEntry.userid = user
        newEntry.dateTime = dT
        newEntry.bloodsugarreading = BSreading
        newEntry.estcarbcount = estCC
        newEntry.insulinintake = II
        newEntry.notes = note
        return newEntry
    }
}