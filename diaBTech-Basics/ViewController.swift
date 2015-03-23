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
    var userData = [userhealth]()
    var userA1CData = [userA1C]()
    
    
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
    

    //managedObjectContext var
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(FB.hasActiveSession()){
            println("FACEBOOK HAS ACTIVE SESSION")
            performSegueWithIdentifier("registrationScene1", sender: fbLogin)
        }
        else{
            println("FACEBOOK DOES NOT HAVE ACTIVE SESSION.")
        }
        
        fbLogin.delegate = self;
        fbLogin.sizeToFit();
        
        
 //       self.drTable.delegate = self
 //       self.drTable.dataSource = self
  
        //manually put in a object
      //  if let moc = self.managedObjectContext {
            //userData.createInManagedObjectHealth(moc, )
       // }
        
       // self.fbLogin.readPermissions = [@"public_profile", @"email", @"user_friends"];

        
        
    }
    
    @IBAction func addLog(sender: AnyObject) {
        if let moc = self.managedObjectContext {
            var dateAA: NSDate = dateActivity.date
            var doubleII : Double = NSString(string: insulinActivity.text).doubleValue
            var doubleCC : Double = NSString(string: ccActivity.text).doubleValue
            let readingInt:Int = readingActivity.text.toInt()!
            let noteString:NSString = notesActivity.text!
            userhealth.createInManagedObjectContextHealth(moc, dT: dateAA, BSreading: readingInt, estCC: doubleCC, II: doubleII, note: noteString)
        }
        
        var viewFrame = self.view.frame
        viewFrame.origin.y += 20
        
    }
    
    @IBAction func addRegister(sender: AnyObject) {
        if let moc = self.managedObjectContext {
            var fbFirstName = "First"
            var fbLastName = "Last"
        //    useridTable.createInManagedObjectContextID(moc: NSManagedObjectContext, fbUserFN: fbFirstName
        //        , fbUserLN: fbLastName, userEmail: String, endoEmail: <#String#>, nextAPPT: <#NSDate#>, morningMT: <#TimeRecord#>, lunchMT: <#TimeRecord#>, dinnerMT: <#TimeRecord#>, snack1MT: <#TimeRecord#>, snack2MT: <#TimeRecord#>, minBS: <#Int#>, maxBS: <#Int#>)
        }
    }
    
    @IBAction func addA1C(sender: AnyObject) {
        var dateA1C: NSDate = dateTimeA1C.date
        var readingDouble : Double  = NSString(string: readingA1C.text).doubleValue
        if let moc = self.managedObjectContext {
            userA1C.createInManagedObjectContextA1C(moc, dT: dateA1C, reading: readingDouble)
        }
    }
    
    
    //FB delegate methods
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("Has session: ", FBSession.activeSession());
        println("User Logged In");
    }
    /**
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        nameLabel.text = "Hey \(user.name)!"
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error : \(error.localizedDescription)")
    }*/
    
    //end of FB edit


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

