//
//  user-idTable.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

class useridTable: NSManagedObject {
    @NSManaged var fbuserfname: String
    @NSManaged var fbuserlname: String
    @NSManaged var fbemail: String
    @NSManaged var endoemail: String
    @NSManaged var nextendoapt: NSDate
    @NSManaged var morningmealtime: NSDate
    @NSManaged var lunchmealtime: NSDate
    @NSManaged var dinnermealtime: NSDate
    @NSManaged var snack1mealtime: NSDate
    @NSManaged var snack2mealtime: NSDate
    @NSManaged var minGoalBS: Int
    @NSManaged var maxGoalBS: Int
    
    
    class func createInManagedObjectContextID(moc: NSManagedObjectContext, fbUserFN: String, fbUserLN: String, userEmail: String, endoEmail:String, nextAPPT: NSDate, morningMT: TimeRecord, lunchMT: TimeRecord, dinnerMT: TimeRecord, snack1MT: TimeRecord, snack2MT: TimeRecord, minBS: Int, maxBS: Int) -> useridTable {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("useridTable", inManagedObjectContext: moc) as useridTable
     /*   newItem.fbuserfname = fbUserFN
        newItem.fbuserlname = fbUserLN
        newItem.fbemail = userEmail
        newItem.endoemail = endoEmail
        newItem.nextendoapt = nextAPPT
        newItem.morningmealtime = morningMT
        newItem.lunchmealtime = lunchMT
        newItem.dinnermealtime = dinnerMT
        newItem.snack1mealtime = snack1MT
        newItem.snack2mealtime = snack2MT
        newItem.minGoalBS = minBS
        newItem.maxGoalBS = maxBS*/
        return newItem
    }
}