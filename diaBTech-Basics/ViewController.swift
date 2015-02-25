//
//  ViewController.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 1/26/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, FBLoginViewDelegate {
    @IBOutlet var fbLoginView : FBLoginView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Has session: ");
       // self.fbLoginView.delegate = self
       // self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        
        
        
        
    }
    
    //FB delegate methods
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("Has session: ", FBSession.activeSession());
        println("User Logged In");
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        nameLabel.text = "Hey \(user.name)!"
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error : \(error.localizedDescription)")
    }
    
    //end of FB edit


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

