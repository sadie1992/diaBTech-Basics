//
//  user-idTable.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import CoreData

@objc(UserID)
class UserID: NSManagedObject {
    @NSManaged var fbUserFname: String
    @NSManaged var fbUserLname: String
    @NSManaged var fbEmail: String
    @NSManaged var endoEmail: String
    @NSManaged var nextEndoApt: String
    @NSManaged var morningMealTime: String
    @NSManaged var lunchMealTime: String
    @NSManaged var dinnerMealTime: String
    @NSManaged var snack1MealTime: String
    @NSManaged var snack2MealTime: String
    @NSManaged var minGoalBS: Int16
    @NSManaged var maxGoalBS: Int16
    
    
    class func createInManagedObjectContextID(moc: NSManagedObjectContext, fbUserFN: String, fbUserLN: String, userEmail: String, endoEmail:String, nextAPPT: String, morningMT: String, lunchMT: String, dinnerMT: String, snack1MT: String, snack2MT: String, minBS: Int, maxBS: Int) -> UserID {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("UserID", inManagedObjectContext: moc) as UserID
        
        // var newUser = NSEntityDescription.insertNewObjectForEntityForName("UserID", inManagedObjectContext: managedObjectContext) as NSManagedObject
        
        newItem.fbUserFname = fbUserFN
        newItem.fbUserLname = fbUserLN
        newItem.fbEmail = userEmail
        newItem.endoEmail = endoEmail
        newItem.nextEndoApt = nextAPPT
        newItem.morningMealTime = morningMT
        newItem.lunchMealTime = lunchMT
        newItem.dinnerMealTime = dinnerMT
        newItem.snack1MealTime = snack1MT
        newItem.snack2MealTime = snack2MT
        newItem.minGoalBS = Int16(minBS)
        newItem.maxGoalBS = Int16(maxBS)
        return newItem
    }

}