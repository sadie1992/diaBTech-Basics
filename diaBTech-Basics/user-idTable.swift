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
    @NSManaged var userid: Int
    @NSManaged var fbuserfname: String
    @NSManaged var buserlname: String
    @NSManaged var userage: Int
    @NSManaged var usergender: String
    @NSManaged var fbemail: String
    @NSManaged var endoemail: String
    @NSManaged var nextendoapt: NSDate
    @NSManaged var morningmealtime: NSDate
    @NSManaged var lunchmealtime: NSDate
    @NSManaged var dinnermealtime: NSDate
    @NSManaged var snack1mealtime: TimeRecord
    @NSManaged var snack2mealtime: TimeRecord
}