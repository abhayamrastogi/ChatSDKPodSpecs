//
//  RGConnectSettings.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation


public struct RGConnectSettings {
    
    static var BASE_URL: String! = "https://connect.round.glass"
    
    static var METEOR_VERSION: String! = "pre2"
    
    static let METEOR_SUBSCRIPTIONS: [String] = [
                                                    "activeUsers",
                                                    "subscription",
                                                    "rocketchat_subscription"
                                                ]
    
    /**
     Method to set Base Url to initialize Connection to the Server.
     
     - parameter url: Base Url of the Server
     */
    public static func setApiURL(url: String) {
        RGConnectSettings.BASE_URL = url
    }
    
    /**
     Method to set Meteor Version to establish DDP Connection to the Server. The version should be compatible with the version accepted by the Server.
     
     - parameter meteorVersion: Meteor Version String.
     */
    public static func setMeteorVersion(meteorVersion: String) {
        RGConnectSettings.METEOR_VERSION = meteorVersion
    }
}