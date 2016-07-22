//
//  RGChatRoomService.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

public class RGChatRoomService: NSObject {
    
    var meteorClient: MeteorClient!
    
    public init(meteorClient: MeteorClient) {
        super.init()
    }
    
    /**
     Method to fetch list of Chat Rooms from the server from the specified collection.
     - parameter successCallback: SuccessCallback returns a list of ChatRooms if request is successfull.
     - parameter errorCallback:   ErrorCallback returns an NSError Object if request fails.
     */
    func getChatRooms(successCallback: (chatRooms: [ChatRoom]) -> Void,
                      errorCallback: (error: NSError) -> Void) {
        
        ChatRoomNetworkHandler.getChatRooms(self.meteorClient, successCallback: { (chatRooms) in
            
            successCallback(chatRooms: chatRooms)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    
    /**
     Method to create a Public channel with the specified channel name.
     
     - parameter channelName:     Name to be set for the channel
     - parameter successCallback: Returns a SuccessCallback if channel is created successfully.
     - parameter errorCallback:   Returns a NSError Object if channel creation failed.
     */
    public func createChannel(channelName: String,
                       successCallback: (response: [NSObject : AnyObject]) -> Void,
                       errorCallback: (error: NSError) -> Void) {
        
        ChatRoomNetworkHandler.createChannel(self.meteorClient, channelName: channelName, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
    
    /**
     Method to create Direct Message with the User whose username is specified.
     
     - parameter userName:        Name of the User.
     - parameter successCallback: Returns a SuccessCallback if Direct Message is created successfully.
     - parameter errorCallback:   Returns a NSError Object if request failed.
     */
    public func createDirectMessage(userName: String,
                                    successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                    errorCallback: ((error: NSError) -> Void)) {
        
        ChatRoomNetworkHandler.createDirectMessage(self.meteorClient, userName: userName, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
        
            errorCallback(error: error)
        }
    }
}