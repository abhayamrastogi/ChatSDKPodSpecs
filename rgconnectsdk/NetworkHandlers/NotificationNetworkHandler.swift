//
//  NotificationNetworkHandler.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

class NotificationNetworkHandler {
    
    /**
     Method to Subscribe for Push Notification using Device Token.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter deviceToken:     <#deviceToken description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func subscribeForPushNotification(meteorClient: MeteorClient,
                                        deviceToken: String,
                                        successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                        errorCallback: ((error: NSError) -> Void)) {
        
        let pushParameters:[String:AnyObject] = [
            "token":["apn":deviceToken],
            "appName":"iPhone",
            "id":"",
            "metadata":["":""],
            "userId":meteorClient.userId
        ]
        
        meteorClient.callMethodName("raix:push-update", parameters: [pushParameters]) { (result, error) in
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
}