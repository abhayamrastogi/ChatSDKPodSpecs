//
//  RGSocketManager.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import ObjectMapper

public class RGSocketManager: NSObject {
    
    var delegates: [RGConnectChatDelegate]! = []
    
    override init() {
        super.init()
        
        /**
         Observers for Chat Connection Events.
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.chatConnected), name: MeteorClientDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.chatDisconnected), name: MeteorClientDidDisconnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGConnectChatDelegate.chatConnectionReady), name: MeteorClientConnectionReadyNotification, object: nil)
        
        /**
         Observers for Chat Message related events.
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didAddMessage(_:)), name: "stream-messages_added", object: nil)
        
        /**
         Observers for Chat Room related events.
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didAddChatRoom(_:)), name: "rocketchat_subscription_added", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didRemoveChatRoom(_:)), name: "rocketchat_subscription_removed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didUpdateChatRoom(_:)), name: "rocketchat_subscription_changed", object: nil)
        
        /**
         Observers for User related events.
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didAddUser(_:)), name: "users_added", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didRemoveUser(_:)), name: "users_removed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RGSocketManager.didUpdateUser(_:)), name: "users_changed", object: nil)

    }
    
    
    /**
     Method called when the Chat is Connected. In turn calls the chatDidConnect function of the RGConnectChatDelegate.
     */
    func chatConnected() {
        for delegate in delegates {
            delegate.chatDidConnect?()
        }
    }
    
    /**
     Method called when the Chat is Disconnected. In turn calls the chatDidDisconnect function of the RGConnectChatDelegate.
     */
    func chatDisconnected() {
        for delegate in delegates {
            delegate.chatDidDisconnect?()
        }
    }
    
    /**
     Method called when the Chat Connection is ready to send and reveive messages. In turn calls the chatConnectionReady method of RGConnectChatDelegate.
     */
    func chatConnectionReady() {
        for delegate in delegates {
            delegate.chatConnectionReady?()
        }
    }
    
    /**
     Method called when a message is added to the collection. In turn calls the chatMessageAdded method of RGConnectChatDelegate.
     
     - parameter notification: <#notification description#>
     */
    func didAddMessage(notification: NSNotification) {
        
        if let args = notification.userInfo?["args"] {
            for delegate in delegates {
                delegate.chatMessageAdded?(Mapper<ChatMessage>().map(args[1])!)
            }
        }
    }
    
    /**
     Method called when a chat room is added to the collection. In turn calls the chatRoomAdded method of RGConnectChatDelegate.
     
     - parameter notification: <#notification description#>
     */
    func didAddChatRoom(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.chatRoomAdded?(Mapper<ChatRoom>().map(args)!)
            }
        }
    }
    
    /**
     Method called when a chat room is removed from the collection. In turn calls the chatRoomRemoved method of RGConnectChatDelegate.
     
     - parameter notification: <#notification description#>
     */
    func didRemoveChatRoom(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.chatRoomRemoved?(Mapper<ChatRoom>().map(args)!)
            }
        }
    }
    
    /**
     Method called when a chat room is updated in the collection. In turn calls the chatRoomUpdated method of RGConnectChatDelegate.
     
     - parameter notification: <#notification description#>
     */
    func didUpdateChatRoom(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.chatRoomUpdated?(Mapper<ChatRoom>().map(args)!)
            }
        }
    }
    
    func didAddUser(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.userAdded?(Mapper<User>().map(args)!)
            }
        }
    }
    
    func didRemoveUser(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.userRemoved?(Mapper<User>().map(args)!)
            }
        }
    }
    
    func didUpdateUser(notification: NSNotification) {
        
        if let args = notification.userInfo {
            for delegate in delegates {
                delegate.userUpdated?(Mapper<User>().map(args)!)
            }
        }
    }
    
}