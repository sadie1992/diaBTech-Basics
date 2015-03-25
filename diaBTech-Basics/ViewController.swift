//
//  ViewController.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, FBLoginViewDelegate, UITableViewDelegate, UITableViewDataSource {

    var userItems = [useridTable]()
    var userData = [Userhealth]()
    var userA1CData = [UserA1C]()
    
    
    //all outlets for an Activity (non-a1c)
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateActivity: UIDatePicker!
    
    @IBOutlet weak var readingActivity: UITextField!
    
    @IBOutlet weak var ccActivity: UITextField!
    
    @IBOutlet weak var insulinActivity: UITextField!
    
    @IBOutlet weak var notesActivity: UITextView!
    
    //all outlets for an A1C 
    @IBOutlet weak var dateTimeA1C: UIDatePicker!
    
    @IBOutlet weak var readingA1C: UITextField!
    
    
    //outlets for graphing
    @IBOutlet weak var startDateGraph: UIDatePicker!
    
    @IBOutlet weak var endDateGraph: UIDatePicker!
    
    @IBOutlet weak var a1cGraph: UISwitch!
    
    //outlets for exporting
    @IBOutlet weak var startDateExport: UIDatePicker!
    
    @IBOutlet weak var endDateExport: UIDatePicker!
    
    @IBOutlet weak var a1cExport: UISwitch!
    
    
    //outlets for comments
    @IBOutlet weak var comments: UITextView!
    
    
    //table for Diabetic Resources
    //for links: https://www.youtube.com/watch?v=gMR0cvVToNc 
    @IBOutlet weak var drTable: UITableView!
    var links: [String]  = ["one", "two",
        "three", "four", "five"]
    
    //table for Activity Log
    @IBOutlet weak var logTable: UITableView!
    
    //achievement table
    @IBOutlet weak var achievementTable: UITableView!
    
    @IBOutlet weak var fbLogin: FBLoginView!
    var hasSession: Boolean!
    
    @IBOutlet weak var landPageText: UILabel!
    
    

    //managedObjectContext var
    /*lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    @IBAction func regMenu(sender: AnyObject) {
        if(FB.hasActiveSession()){
            performSegueWithIdentifier("registrationScene1", sender: nil)
            println("HasSession is true");
        }
        else{
            //show error message
            println("HasSession is false");
        }
        
    }
    
    @IBAction func addLog(sender: AnyObject) {
        /*if let moc = self.managedObjectContext {
            var dateAA: NSDate = dateActivity.date
            var doubleII : Double = NSString(string: insulinActivity.text).doubleValue
            var doubleCC : Double = NSString(string: ccActivity.text).doubleValue
            let readingInt:Int = readingActivity.text.toInt()!
            let noteString:NSString = notesActivity.text!
            userhealth.createInManagedObjectContextHealth(moc, dT: dateAA, BSreading: readingInt, estCC: doubleCC, II: doubleII, note: noteString)
        }*/
        var doubleII : Double = NSString(string: insulinActivity.text).doubleValue
        var doubleCC : Double = NSString(string: ccActivity.text).doubleValue
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var newHealth = NSEntityDescription.insertNewObjectForEntityForName("UserHealth", inManagedObjectContext: context) as NSManagedObject
        
        newHealth.setValue(dateActivity.date, forKey: "dateTime")
        newHealth.setValue(doubleII, forKey: "insulinInTake")
        newHealth.setValue(doubleCC, forKey: "estCarbCount")
        newHealth.setValue(readingActivity.text.toInt(), forKey: "bloodSugarReading")
        newHealth.setValue(notesActivity.text, forKey: "notes")
        
        context.save(nil);
        
        var viewFrame = self.view.frame
        viewFrame.origin.y += 20
        
    }
    
    @IBAction func addRegister(sender: AnyObject) {
      //  if let moc = self.managedObjectContext {
            var fbFirstName = "First"
            var fbLastName = "Last"
       
       // }
    }
    
    @IBAction func addA1C(sender: AnyObject) {
        var readingDouble : Double  = NSString(string: readingA1C.text).doubleValue
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext!
       var newA1C = NSEntityDescription.insertNewObjectForEntityForName("UserA1C", inManagedObjectContext: context) as NSManagedObject
        newA1C.setValue(dateTimeA1C.date, forKey: "dateTime")
        newA1C.setValue(readingDouble, forKey: "a1c")
        
        context.save(nil);
    }
    
    
    //FB delegate methods
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("Has session: ", FBSession.activeSession());
        println("User Logged In");
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.links.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = drTable.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        cell?.textLabel?.text = NSString(format: "%d", indexPath.row)
        //cell="row#\(indexPath.row)"
        // cell.detailTextLabel.text="subtitle#\(indexPath.row)"
        
        return cell!
    }

}

