//
//  ChatRoomNetworkHandler.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 19/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import ObjectMapper

class ChatRoomNetworkHandler {
    
    /**
     Method to fetch a list Of All Chat Rooms.
     
     - parameter meteorClient:    Meteor Client Object.
     - parameter collectionName:  Collection Name.
     - parameter successCallback: Success Callback with list of Chat Rooms.
     - parameter errorCallback:   Error Callback with NSError.
     */
    static func getChatRooms(meteorClient: MeteorClient,
                             successCallback: (chatRooms: [ChatRoom]) -> Void,
                             errorCallback: (error: NSError) -> Void) {
        
        var chatRooms = [ChatRoom]()
        
        let chatRoomSubscription = meteorClient.collections["rocketchat_subscription"] as? M13MutableOrderedDictionary
        
        if let chatRoomSubscription = chatRoomSubscription {
            for key in 0..<chatRoomSubscription.count {
                chatRooms.append(Mapper<ChatRoom>().map(chatRoomSubscription[key])!)
            }
            
            successCallback(chatRooms: chatRooms)
        } else {
            let error = NSError(domain: "Chat Rooms Not Found.", code: 0, userInfo: nil)
          
            errorCallback(error: error)
        }
    }
    
    /**
     Method to Create a Public Channel.
     
     - parameter meteorClient:    Meteor Client Object.
     - parameter channelName:     Name of the Channel to be created.
     - parameter successCallback: Success response
     - parameter errorCallback:   Failure Response.
     */
    static func createChannel(meteorClient: MeteorClient, channelName: String,
                              successCallback: (response: [NSObject : AnyObject]) -> Void,
                              errorCallback: (error: NSError) -> Void) {
     
        meteorClient.callMethodName("createChannel", parameters: [channelName, []]) { (response, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if response != nil {
                successCallback(response: response)
            }
        }
    }
    
    
    /**
     Method to create a Direct Message.
     
     - parameter meteorClient:    Meteor Client Object.
     - parameter userName:        Name of the User for Direct Message.
     - parameter successCallback: Success Response.
     - parameter errorCallback:   Failure Response.
     */
    static func createDirectMessage(meteorClient: MeteorClient, userName: String,
                                    successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                    errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("createDirectMessage", parameters: [userName, []]) { (response, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if response != nil {
                successCallback(response: response)
            }
        }
    }
    
}