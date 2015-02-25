//
//  user-A1C.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 2/25/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

class userA1C: NSManagedObject {
    @NSManaged var userID: Int
    @NSManaged var dateTime: NSDate
    @NSManaged var a1c: Double
    
    class func createInManagedObjectContextA1C(moc: NSManagedObjectContext, uid: Int, dT: NSDate, reading: Double) -> userA1C{
        let newA1C = NSEntityDescription.insertNewObjectForEntityForName("userA1C" , inManagedObjectContext: moc) as userA1C
        newA1C.userID = uid
        newA1C.dateTime = dT
        newA1C.a1c = reading
        return newA1C
    }
}