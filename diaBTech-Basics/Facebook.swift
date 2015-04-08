//
//  Facebook.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 2/9/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//  Pulled from: https://github.com/rajeshsegu/facebook-ios-swift
//

import Foundation

let FB = Facebook();


class Facebook {
    
    var fbSession:FBSession?;
    
    init(){
        self.fbSession = FBSession.activeSession();
    }
    
    func hasActiveSession() -> Bool{

        let fbsessionState = FBSession.activeSession().state;
        if ( fbsessionState == FBSessionState.Open
            || fbsessionState == FBSessionState.OpenTokenExtended ){
                self.fbSession = FBSession.activeSession();

                println("Signed in: true")
                return true;
        }
        else {
            println("Signed in: false")
            return false;
        }
    }
    
    func login(callback: () -> Void){
        
        let permission = ["public_profile", "email"];
 

        
        let activeSession = FBSession.activeSession();
        let fbsessionState = activeSession.state;
        var showLoginUI = true;
        
        if(fbsessionState == FBSessionState.CreatedTokenLoaded){
            showLoginUI = false;
        }
        
        if(fbsessionState != FBSessionState.Open
            && fbsessionState != FBSessionState.OpenTokenExtended){
                FBSession.openActiveSessionWithReadPermissions(
                    permission,
                    allowLoginUI: showLoginUI,
                    completionHandler: { (session:FBSession!, state:FBSessionState, error:NSError!) in
                        
                        if(error != nil){
                            println("Session Error: \(error)");
                        }
                        
                        self.fbSession = session;
                        
                        callback();
                        
                    }
                );
                return;
        }
        
        callback();
        
    }
    
    func logout(){
        self.fbSession?.closeAndClearTokenInformation();
        self.fbSession?.close();
    }
    
    func getInfo(user: FBGraphUser){
            FBRequest.requestForMe()?.startWithCompletionHandler({(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) in
            
            if(error != nil){
                println("Error Getting ME: \(error)");
            }
            
           // let fbName: NSString? = userData["name"] as? NSString;
            println("\(result)");
      //      println("Username is: ", fbName);
            
            
        });
    }
    
    
    func handleDidBecomeActive(){
        FBAppCall.handleDidBecomeActive();
    }
    
}
