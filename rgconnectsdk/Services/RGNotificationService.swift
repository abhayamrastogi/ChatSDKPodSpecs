//
//  RGNotificationService.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation


public class RGNotificationService: NSObject {
    
    var meteorClient: MeteorClient!
    
    public init(meteorClient: MeteorClient) {
        self.meteorClient = meteorClient
        super.init()
    }
    
    /**
     Method to send the Device Token String to the server for subscription.
     
     - parameter deviceToken:     Device Token to be sent to the server
     - parameter successCallback: Returns Successcallback if device token properly registered to the server.
     - parameter errorCallback:   Returns an NSError Object if request fails.
     */
    public func subscribeForPushNotification(deviceToken: String,
                                             successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                             errorCallback: ((error: NSError) -> Void)) {
        
        NotificationNetworkHandler.subscribeForPushNotification(self.meteorClient, deviceToken: deviceToken, successCallback: { (response) in

            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
}