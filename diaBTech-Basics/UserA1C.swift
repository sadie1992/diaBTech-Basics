//
//  user-A1C.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 2/25/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

@objc(UserA1C)
class UserA1C: NSManagedObject {
    @NSManaged var dateTime: NSDate
    @NSManaged var a1c: Double
    
    class func createInManagedObjectContextA1C(moc: NSManagedObjectContext, dT: NSDate, reading: Double) -> UserA1C {
        let newA1C = NSEntityDescription.insertNewObjectForEntityForName("UserA1C" , inManagedObjectContext: moc) as UserA1C
        newA1C.dateTime = dT
        newA1C.a1c = reading
        return newA1C
    }
}