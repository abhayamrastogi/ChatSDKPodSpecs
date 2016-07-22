//
//  RGConnectSharedManager.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation


public class RGConnectSharedManager: NSObject {
    
    /**
     * Service Class Variables.
     *
     */
    public var chatMessageService: RGChatMessageService!
    
    public var userService: RGUserService!
    
    public var chatRoomService: RGChatRoomService!
    
    public var notificationService: RGNotificationService!
    
    private var socketManager: RGSocketManager!
    /**
     Static singleton instance for RGConnectSharedManager.
     
     - returns: <#return value description#>
     */
    public static func sharedInstance() -> RGConnectSharedManager {
        return RGConnectSharedManager()
    }
    
    /**
     Initialize RGConnectSharedManager.
     
     - returns: <#return value description#>
     */
    override init() {
        super.init()
        
        // TODO:- Look into initialisation of Services and Socket Manager. Should not clash.
        
        self.socketManager = RGSocketManager()

        let meteorClient = MeteorService.initializeMeteor()
        MeteorService.addMeteorSubscriptions(meteorClient)
        self.initializeServices(meteorClient)
    }
    
    /**
     Function to initialize Services.
     
     - parameter meteorClient: Meteor Client Object to initialize all the Services.
     
     */
    private func initializeServices(meteorClient: MeteorClient) {
        self.chatMessageService = RGChatMessageService(meteorClient: meteorClient)
        self.userService = RGUserService(meteorClient: meteorClient)
        self.chatRoomService = RGChatRoomService(meteorClient: meteorClient)
        self.notificationService = RGNotificationService(meteorClient: meteorClient)
    }
    
    /**
     Method to Add Delegate to the Socket Manager Class. All the socket connection activities will be broadcasted on these delegates.
     
     - parameter delegate: RGConnectDelegate Subclass.
     */
    public func addDelegate(delegate: RGConnectChatDelegate) {
        self.socketManager.delegates.append(delegate)
    }
}