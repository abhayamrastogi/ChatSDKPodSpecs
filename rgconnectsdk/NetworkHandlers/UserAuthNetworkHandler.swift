//
//  UserAuthNetworkHandler.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import ObjectMapper


public enum UserPresenceStatus: String {
    case Online = "online"
    case Away = "away"
    case Busy = "busy"
    case Offline = "offline"
}

class UserAuthNetworkHandler {
    
    /**
     Method to Login to Chat Server using Session Token.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter sessionToken:    <#sessionToken description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func loginWithSessionToken(meteorClient: MeteorClient, sessionToken: String,
                                      successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                      errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.logonWithSessionToken(sessionToken) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
    
    /**
     Method to Send User Presence Status.
     
     - parameter meteorClient:       <#meteorClient description#>
     - parameter userPresenceStatus: <#userPresenceStatus description#>
     - parameter successCallback:    <#successCallback description#>
     - parameter errorCallback:      <#errorCallback description#>
     */
    static func setUserPresenceStatus(meteorClient: MeteorClient,
                                      userPresenceStatus: UserPresenceStatus,
                                      successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                      errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("UserPresence:setDefaultStatus", parameters: [userPresenceStatus.rawValue]) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
    
    /**
     Method to fetch username suggestions for the user.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func getUsernameSuggestions(meteorClient: MeteorClient,
                                       successCallback: ((response: String?) -> Void),
                                       errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("getUsernameSuggestion", parameters: []) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                let username = result["result"] as? String
                successCallback(response: username)
            }
        }
    }
    
    /**
     Method to Send Forgot Password Email with Link to the User.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter email:           <#email description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func sendForgotPasswordEmail(meteorClient: MeteorClient, email: String,
                                        successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                        errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("sendForgotPasswordEmail", parameters: [email]) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
    
    
    /**
     Method to Set Username for a particular User.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter username:        <#username description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func setUsername(meteorClient: MeteorClient, username: String,
                            successCallback: ((response: [NSObject: AnyObject]) -> Void),
                            errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("setUsername", parameters: []) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
    
    /**
     Method to get Current User from the Users Collection
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func getCurrentUser(meteorClient: MeteorClient,
                               successCallback: ((user: User) -> Void),
                               errorCallback: ((error: NSError) -> Void)) {
     
        let users = meteorClient.collections["users"] as? M13OrderedDictionary
        
        if let users = users {
            let user = Mapper<User>().map(users[meteorClient.userId] as! NSDictionary)
            successCallback(user: user!)
        } else {
            
            let error = NSError(domain: "User Not Found.", code: 0, userInfo: nil)
            errorCallback(error: error)
        }
    }
    
    /**
     Method to logout User.
     
     - parameter meteorClient: <#meteorClient description#>
     */
    static func logoutUser(meteorClient: MeteorClient) {
        meteorClient.logout()
    }
}