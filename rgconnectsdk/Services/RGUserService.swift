//
//  RGUserService.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

public class RGUserService: NSObject {
    
    private var meteorClient: MeteorClient!
    
    public init(meteorClient: MeteorClient) {
        self.meteorClient = meteorClient
        super.init()
    }
    
    /**
     Method to Login User to Server With Session Token.
     
     - parameter sessionToken:    Session Token using which the User will login to the Server.
     - parameter successCallback: Returns Success Response if login was successfull.
     - parameter errorCallback:   Returns NSError Object if request fails.
     */
    public func loginWithSessionToken(sessionToken: String,
                                      successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                      errorCallback: ((error: NSError) -> Void)) {
        
        UserAuthNetworkHandler.loginWithSessionToken(self.meteorClient, sessionToken: sessionToken, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        
        }
    }
    
    /**
     Method to Set User Presence Status. Can take 4 values:- Online, Away, Busy, Offline.
     
     - parameter userPresenceStatus: User Presence Status to be set.
     - parameter successCallback:    Returns SuccessCallback if status is set Successfully
     - parameter errorCallback:      Returns NSError Object if request fails.
     */
    public func setUserPresenceStatus(userPresenceStatus: UserPresenceStatus,
                                      successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                      errorCallback: ((error: NSError) -> Void)) {
        
        UserAuthNetworkHandler.setUserPresenceStatus(self.meteorClient, userPresenceStatus: userPresenceStatus, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        
        }
    }
    
    /**
     Method to send Forgot Password Email Link for the given User.
     
     - parameter username:        Username of the User.
     - parameter successCallback: Return SuccessCallback if email link sent successfully
     - parameter errorCallback:   Returns NSError Object if request fails.
     */
    public func sendForgotPasswordEmail(username: String,
                                        successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                        errorCallback: ((error: NSError) -> Void)) {
        
        UserAuthNetworkHandler.sendForgotPasswordEmail(self.meteorClient, email: username, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    /**
     Method to get Username Suggestions for the User.
     
     - parameter successCallback: Returns SuccessCallback if username suggestions request is successfull.
     - parameter errorCallback:   Returns NSError Object if request fails.
     */
    public func getUsernameSuggestions(successCallback: ((response: String?) -> Void),
                                errorCallback: ((error: NSError) -> Void)) {
        
        UserAuthNetworkHandler.getUsernameSuggestions(self.meteorClient, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    /**
     Method to Set Username for the User.
     
     - parameter username:        Username String to be set.
     - parameter successCallback: Returns Successcallback if the username is successfully set.
     - parameter errorCallback:   Returns NSError Object if request fails.
     */
    public func setUsername(username: String,
                            successCallback: ((response: [NSObject: AnyObject]) -> Void),
                            errorCallback: ((error: NSError) -> Void)) {
        
        UserAuthNetworkHandler.setUsername(self.meteorClient, username: username, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    /**
     Method to fetch Current User from the User Collection based on User Id.
     
     - parameter successCallback: Returns the current User Object if request is successfull.
     - parameter errorCallback:   Returns an NSError Object if request failed.
     */
    public func getCurrentUser(successCallback: ((user: User) -> Void),
                               errorCallback: ((error: NSError) -> Void)) {
     
        UserAuthNetworkHandler.getCurrentUser(self.meteorClient, successCallback: { (user) in
            
            successCallback(user: user)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    /**
     Method to logout User from the Server.
     */
    public func logoutUser() {
        UserAuthNetworkHandler.logoutUser(self.meteorClient)
    }
    
}