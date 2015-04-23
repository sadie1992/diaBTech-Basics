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
        //if let moc = self.managedObjectContext {
        
        //}
    }
    
    override func viewWillAppear(animated: Bool) {
        //logTable.reloadData()
    }
    
    @IBAction func regMenu(sender: AnyObject) {

        if(!shouldPerformSegueWithIdentifier("registrationScene1", sender: nil)){
           // if(FB.hasActiveSession()){
                shouldPerformSegueWithIdentifier("toMenu", sender: nil)
            //}
        }
            /*(else if (!shouldPerformSegueWithIdentifier("registrationScene1", sender: nil)){
                
                println("*** NOPE, segue will not occur")
                //show error message
                println("HasSession is false");
                let alert = UIAlertView()
                alert.title = "Sign In Alert"
                alert.message = "In order to navigate further, you must sign into Facebook."
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        
        
            */
        
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var fetReq = NSFetchRequest(entityName: "UserID")
        let predicate = NSPredicate(format: "fbEmail == %@", fbStuff.email);
        
        fetReq.predicate = predicate;
        
        let userItems: [UserID] = managedObjectContext.executeFetchRequest(fetReq, error: nil) as [UserID]!
        
        println("Can find a user in CD: ", userItems.count)
        
        if identifier == "toMenu" { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
            
            var segueShouldOccur = (userItems.count > 0)
            
            if !segueShouldOccur {
                println("*** NOPE, segue wont occur")
                return false
            }
            
        }
        else if (identifier == "registrationScene1") {
            if !FB.hasActiveSession() {
                println("*** NOPE, segue will not occur")
                //show error message
                println("HasSession is false");
                let alert = UIAlertView()
                alert.title = "Sign In Alert"
                alert.message = "In order to navigate further, you must sign into Facebook."
                alert.addButtonWithTitle("Ok")
                alert.show()
                return false
            }
        }
        return true
    }
    
    
    @IBAction func addLog(sender: AnyObject) {
        
        var doubleII : Double = NSString(string: insulinActivity.text).doubleValue
        var doubleCC : Double = NSString(string: ccActivity.text).doubleValue
        

       // var newHealth = NSEntityDescription.insertNewObjectForEntityForName("UserHealth", inManagedObjectContext: context) as NSManagedObject
       /*
        newHealth.setValue(dateActivity.date, forKey: "dateTime")
        newHealth.setValue(doubleII, forKey: "insulinInTake")
        newHealth.setValue(doubleCC, forKey: "estCarbCount")
        newHealth.setValue(readingActivity.text.toInt(), forKey: "bloodSugarReading")
        newHealth.setValue(notesActivity.text, forKey: "notes")
    */
        var newHealth = UserHealth.createInManagedObjectContextHealth(managedObjectContext, dT: dateActivity.date, BSreading: readingActivity.text.toInt()!, estCC: doubleCC, II: doubleII, note: notesActivity.text)
        save()
        println("Did newHealth change? ", newHealth.hasChanges);

        println(newHealth.hasChanges)
    }
    
   
    @IBAction func addRegister(sender: AnyObject) {
        
       // if(fbStuff.email == nil){
            println("Name:" + fbStuff.fName + " " + fbStuff.lName)
            println("Email: " + fbStuff.email)
       // }
       // else {
        
           // var newUser = NSEntityDescription.insertNewObjectForEntityForName("UserID", inManagedObjectContext: managedObjectContext) as NSManagedObject
           // newUser.setValue(fbStuff.fName, forKey: "fbUserFname")
            println("User First Name: " + fbStuff.fName)
            
            //newUser.setValue(fbStuff.lName, forKey: "fbUserLname")
            println("User Last Name: " + fbStuff.lName)
            
            //newUser.setValue(endoEmail.text, forKey: "endoEmail")
            println("Endo Email: " + endoEmail.text)
        
            //newUser.setValue(fbStuff.email, forKey: "fbEmail")
            println("Email: " + fbStuff.email)
            //getting times:
            var outputFormat = NSDateFormatter()
            outputFormat.locale = NSLocale(localeIdentifier:"en_US")
            outputFormat.dateFormat = "HH:mm"
            
            
            var apttD = (outputFormat.stringFromDate(aptDate.date))
            //newUser.setValue(apttD, forKey: "nextEndoApt")
            println("Apt Date: " + apttD)
            
            var bM = (outputFormat.stringFromDate(breakMeal.date))
            //newUser.setValue(bM, forKey: "morningMealTime")
            println("Breakfast Time: " + bM)
            
            var lM = (outputFormat.stringFromDate(lunchMeal.date))
            //newUser.setValue(lM, forKey: "lunchMealTime")
            println("Lunch Time: " + lM)
            
            var dM = (outputFormat.stringFromDate(dinnerMeal.date))
            //newUser.setValue(dM, forKey: "dinnerMealTime")
            println("Dinner Time: " + dM)
            
            var sM1 = (outputFormat.stringFromDate(snack1Meal.date))
            //newUser.setValue(sM1, forKey: "snack1MealTime")
            println("Snack 1 Time: " + sM1)
            
            var sM2 = (outputFormat.stringFromDate(snack2Meal.date))
            //newUser.setValue(sM2, forKey: "snack2MealTime")
            println("Snack 2 Time: " + sM2)
            
            //newUser.setValue(minGoal.text.toInt(), forKey: "minGoalBS")
            println("Min Goal: " + minGoal.text)
            
            //newUser.setValue(maxGoal.text.toInt(), forKey: "maxGoalBS")
            println("Max Goal: " + maxGoal.text)
            //context.save(nil)
        
            var newUser = UserID.createInManagedObjectContextID(self.managedObjectContext, fbUserFN: fbStuff.fName, fbUserLN: fbStuff.lName, userEmail: fbStuff.email, endoEmail: endoEmail.text, nextAPPT: apttD, morningMT: bM, lunchMT: lM, dinnerMT: dM, snack1MT: sM1, snack2MT: sM2, minBS: minGoal.text.toInt()!, maxBS: maxGoal.text.toInt()!)
            save()
            println("Did newUser save? ", newUser.didSave())
        
            println(managedObjectContext.hasChanges)
    
        
        
    }
    
    @IBAction func addA1C(sender: AnyObject) {
        var readingDouble : Double  = NSString(string: readingA1C.text).doubleValue
        //var newA1C = NSEntityDescription.insertNewObjectForEntityForName("UserA1C", inManagedObjectContext: context) as NSManagedObject
        //newA1C.setValue(dateTimeA1C.date, forKey: "dateTime")
        //newA1C.setValue(readingDouble, forKey: "a1c")
        var newA = UserA1C.createInManagedObjectContextA1C(managedObjectContext, dT: dateTimeA1C.date, reading: readingDouble)
        save()
        println("Did newA1C change? ", newA.hasChanges);
        
        println(newA.hasChanges)
    }
    

    @IBAction func viewLogs(sender: AnyObject) {
        
        let fetchReq = NSFetchRequest(entityName: "UserHealth")
        
        let sortDesc = NSSortDescriptor(key: "dateTime", ascending: true)
        fetchReq.sortDescriptors = [sortDesc]
        
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchReq, error: nil) as? [UserHealth] {
            userData = fetchResults
        }
        
      //  var fetchResults = context.executeFetchRequest(fetchReq, error: nil) as [Userhealth]
      //  userData = fetchResults
        println("Number of logs: ", userData.count)
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       /*
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetchReq = NSFetchRequest(entityName: "UserHealth")
        
        
        
        let sortDesc = NSSortDescriptor(key: "dateTime", ascending: true)
        fetchReq.sortDescriptors = [sortDesc]
        
        if let fetchResults = context.executeFetchRequest(fetchReq, error: nil) as? [Userhealth] {
            userData = fetchResults
        }
        
        */
        var fetReq = NSFetchRequest(entityName: "UserHealth")
    
        let userData: [UserHealth] = managedObjectContext.executeFetchRequest(fetReq, error: nil) as [UserHealth]!
        
        println("Can find a user in CD: ", userData.count)
        
        // How many rows are there in this section?
        // There's only 1 section, and it has a number of rows
        // equal to the number of logItems, so return the count
        println("Number of entries for userData: ", userData.count)
        return userData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        logTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
        let cell:UITableViewCell = logTable.dequeueReusableCellWithIdentifier("LogCell") as UITableViewCell
        logTable.dataSource = self
        logTable.delegate = self
        
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
        let logItem = userData[indexPath.row]
        println(logItem.bloodSugarReading)
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

