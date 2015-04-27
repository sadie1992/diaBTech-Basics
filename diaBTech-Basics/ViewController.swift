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
    var userItems = [UserID]()
    var userData = [UserHealth]()
    var userA1CData = [UserA1C]()
    
    @IBOutlet weak var nextBTN: UIButton!
    //all outlets for registration 
    @IBOutlet weak var endoEmail: UITextField!
    @IBOutlet weak var aptDate: UIDatePicker!
    @IBOutlet weak var minGoal: UITextField!
    @IBOutlet weak var maxGoal: UITextField!
    @IBOutlet weak var breakMeal: UIDatePicker!
    @IBOutlet weak var lunchMeal: UIDatePicker!
    @IBOutlet weak var dinnerMeal: UIDatePicker!
    @IBOutlet weak var snack1Meal: UIDatePicker!
    @IBOutlet weak var snack2Meal: UIDatePicker!
    
    
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

    //table for Activity Log
    @IBOutlet weak var logTable: UITableView!
    
    
    //Facebook & Session outlets
    @IBOutlet weak var fbLogin: FBLoginView!
    struct fbStuff {
        static var fName = ""
        static var lName = ""
        static var email = ""
    }
    
    let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func viewWillAppear(animated: Bool) {

        logTable = UITableView(frame: CGRectZero, style: .Plain)
        
    }
    
    @IBAction func regMenu(sender: AnyObject) {
        var shouldPerformMenu = shouldPerformSegueWithIdentifier("toMenu", sender: nil)
        if(shouldPerformMenu && FB.hasActiveSession()){
            performSegueWithIdentifier("toMenu", sender: nil)
            
        }
        else {
            if(FB.hasActiveSession()){
                println("Should perform with toMenu returned false...")
                performSegueWithIdentifier("toRegistration", sender: nil)
            }
            else{
                println("HasSession is false");
                let alert = UIAlertView()
                alert.title = "Sign In Alert"
                alert.message = "In order to navigate further, you must sign into Facebook."
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var fetReq = NSFetchRequest(entityName: "UserID")
        let predicate = NSPredicate(format: "fbEmail == %@", fbStuff.email);
        
        fetReq.predicate = predicate;
        
        let userItems: [UserID] = managedObjectContext.executeFetchRequest(fetReq, error: nil) as [UserID]!
        
        println("Can find a user in CD: ", userItems.count)
        var segueShouldOccur = (userItems.count > 0)
        println("Should segue occur: ", segueShouldOccur.boolValue)
        
        if (identifier == "toMenu") { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
           println("Checking if to Menu should happen...")
            if !segueShouldOccur {
                println("*** NOPE, segue wont occur")
                return false
                
            }
            else{
                println("*** Yes, segue will occur")
            }
        }
        
        return true
    }
    
    
    @IBAction func addLog(sender: AnyObject) {
        var doubleII : Double = NSString(string: insulinActivity.text).doubleValue
        var doubleCC : Double = NSString(string: ccActivity.text).doubleValue
        
        var newHealth = UserHealth.createInManagedObjectContextHealth(managedObjectContext, dT: dateActivity.date, BSreading: readingActivity.text.toInt()!, estCC: doubleCC, II: doubleII, note: notesActivity.text)
        save()
        fetchLogs()
    }
    
   
    @IBAction func addRegister(sender: AnyObject) {
        
            println("User is not registered, save info")

            println("User First Name: " + fbStuff.fName)
            println("User Last Name: " + fbStuff.lName)
            println("Endo Email: " + endoEmail.text)
            println("Email: " + fbStuff.email)
            //getting times:
            var outputFormat = NSDateFormatter()
            outputFormat.locale = NSLocale(localeIdentifier:"en_US")
            outputFormat.dateFormat = "HH:mm"
            
            
            var apttD = (outputFormat.stringFromDate(aptDate.date))
            println("Apt Date: " + apttD)
            
            var bM = (outputFormat.stringFromDate(breakMeal.date))
            println("Breakfast Time: " + bM)
            
            var lM = (outputFormat.stringFromDate(lunchMeal.date))
            println("Lunch Time: " + lM)
            
            var dM = (outputFormat.stringFromDate(dinnerMeal.date))
            println("Dinner Time: " + dM)
            
            var sM1 = (outputFormat.stringFromDate(snack1Meal.date))
            println("Snack 1 Time: " + sM1)
            
            var sM2 = (outputFormat.stringFromDate(snack2Meal.date))
            println("Snack 2 Time: " + sM2)
            
            println("Min Goal: " + minGoal.text)
            
            println("Max Goal: " + maxGoal.text)
        
            var newUser = UserID.createInManagedObjectContextID(self.managedObjectContext, fbUserFN: fbStuff.fName, fbUserLN: fbStuff.lName, userEmail: fbStuff.email, endoEmail: endoEmail.text, nextAPPT: apttD, morningMT: bM, lunchMT: lM, dinnerMT: dM, snack1MT: sM1, snack2MT: sM2, minBS: minGoal.text.toInt()!, maxBS: maxGoal.text.toInt()!)
            save()
    }
    
    @IBAction func addA1C(sender: AnyObject) {
        var readingDouble : Double  = NSString(string: readingA1C.text).doubleValue
        
        var newA = UserA1C.createInManagedObjectContextA1C(managedObjectContext, dT: dateTimeA1C.date, reading: readingDouble)
        save()
        fetchLogs()
    }
    

    @IBAction func viewLogs(sender: AnyObject) {
        fetchLogs()
    }
    
    
    func fetchLogs(){
        let fetchReq = NSFetchRequest(entityName: "UserHealth")
        
        let sortDesc = NSSortDescriptor(key: "dateTime", ascending: true)
        fetchReq.sortDescriptors = [sortDesc]
        
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchReq, error: nil) as? [UserHealth] {
            userData = fetchResults
        }
        
        let aFetReq = NSFetchRequest(entityName: "UserA1C")
        if let fetchARes = managedObjectContext.executeFetchRequest(aFetReq, error: nil) as? [UserA1C]{
            userA1CData = fetchARes
        }
        
        
        println("New number of logs (reg): ", userData.count)
        println("New number of logs (A1C): ", userA1CData.count)
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // println("Can find a user in CD: ", userData.count)
        println("Number of logs (reg): ", userData.count)
        println("Number of logs (A1C): ", userA1CData.count)
        return (userData.count + userA1CData.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        logTable.dataSource = self
        logTable.delegate = self
        logTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
        let cell:UITableViewCell = logTable.dequeueReusableCellWithIdentifier("LogCell", forIndexPath: indexPath) as UITableViewCell
        //var cell:SwiftCell = self.tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.swiftCell, forIndexPath: indexPath) as SwiftCell
        
        // Get the LogItem for this index
        let logItem = userData[indexPath.row].dateTime
        let BGR = userData[indexPath.row].bloodSugarReading
        
        var outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "MM-dd-yyyy 'at' HH:mm"
        var newDate = outputFormat.stringFromDate(logItem)
        // Set the title of the cell to be the title of the logItem
        cell.textLabel?.text = newDate
        cell.textLabel?.textColor = UIColor .blackColor()
        cell.detailTextLabel?.text = String(BGR)
        cell.detailTextLabel?.textColor = UIColor .redColor()
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let logItem = userData[indexPath.row].dateTime
        var outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "MM-dd-yyyy 'at' HH:mm"
        var newDate = outputFormat.stringFromDate(logItem)
        println(newDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nbccLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.nbcc.org/CounselorFind") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func psychTodayLink(sender: AnyObject) {
        if let url = NSURL(string: "https://therapists.psychologytoday.com/rms/prof_search.php") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func abaLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.diabetes.org/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func diabCareLink(sender: AnyObject) {
        if let url = NSURL(string: "http://care.diabetesjournals.org/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    @IBAction func fbLink(sender: AnyObject) {
        if let url = NSURL(string: "https://www.facebook.com/search/str/diabetes/keywords_top") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func sisterLink(sender: AnyObject) {
        if let url = NSURL(string: "https://diabetessisters.org/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func diabulemiaLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.diabulimiahelpline.org/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func lilyLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.lillytruassist.com/_assets/pdf/lillycares_application.pdf") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func copayLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.needymeds.org/copay_diseases.taf?_function=summary&disease_eng=Diabetes") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func lifehackLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.healthline.com/diabetesmine/d-blog-week-going-all-macgyver-with-diabetes-life-hacks") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func domesticLink(sender: AnyObject) {
        if let url = NSURL(string: "https://www.joslin.org/info/diabetes_and_travel_10_tips_for_a_safe_trip.html") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func internationalLink(sender: AnyObject) {
        if let url = NSURL(string: "http://www.diabetesselfmanagement.com/about-diabetes/diabetes-basics/traveling-with-diabetes/planning-for-international-travel/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("User Logged In")
    }
   
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("Username: \(user.first_name) \(user.last_name)")
        fbStuff.fName = user.first_name
        fbStuff.lName = user.last_name
        fbStuff.email = user.objectForKey("email") as String!
        println("Email:  \(fbStuff.email)")

    }
    
    @IBAction func disagreeTOS(sender: AnyObject) {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "In order to use this application, you must agree with the terms of service. Please review the terms above."
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    @IBAction func exportLogs(sender: AnyObject) {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "This functionality is currently in progress. Exporting will be released in a future update. My apologies."
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
}

