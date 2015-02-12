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
    @NSManaged var date: NSDate
    @NSManaged var time: TimeRecord
    @NSManaged var bloodsugarreading: Int
    @NSManaged var estcarbcount: Double
    @NSManaged var insulinintake: Double
    @NSManaged var notes: String
    @NSManaged var a1c: Int
}