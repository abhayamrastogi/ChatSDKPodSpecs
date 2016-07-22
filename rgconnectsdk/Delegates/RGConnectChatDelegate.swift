//
//  RGConnectChatDelegate.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation


@objc public protocol RGConnectChatDelegate {
    
    /**
     Method to notify that a Chat Room was added to the collecion.
     
     - parameter chatRoom: Chat Room Object.
     */
    optional func chatRoomAdded(chatRoom: ChatRoom)
    
    /**
     Method to notify that a particular Chat Room was removed from the  collection.
     
     - parameter chatRoom: Chat Room Object.
     */
    optional func chatRoomRemoved(chatRoom: ChatRoom)
    
    /**
     Method to notify that a particular Chat Room was updated in the collection.
     
     - parameter chatRoom: Chat Room Object.
     */
    optional func chatRoomUpdated(chatRoom: ChatRoom)
    
    /**
     Method to notify that a particular Chat Message was added to the collection.
     
     - parameter chatMessage: Chat Message Object.
     */
    optional func chatMessageAdded(chatMessage: ChatMessage)
    
    /**
     Method to notify that a particular Chat Message was removed from the collection
     
     - parameter chatMessage: Chat Message Object.
     */
    optional func chatMessageRemoved(chatMessage: ChatMessage)
    
    /**
     Method to notify that a particular Chat Message was updated in the collection
     
     - parameter chatMessage: Chat Message Object.
     */
    optional func chatMessageUpdated(chatMessage: ChatMessage)
    
    /**
     Method to notify that a particular User was added in the collection
     
     - parameter user: User Object
     */
    optional func userAdded(user: User)
    
    /**
     Method to notify that a particular User was removed from the collection
     
     - parameter user: User Object
     */
    optional func userRemoved(user: User)
    
    /**
     Method to notify that a particular User was updated in the collection
     
     - parameter user: User Object
     */
    optional func userUpdated(user: User)
    
    /**
     Method to notify that chat client connected to Server
     */
    optional func chatDidConnect()
    
    /**
     Method to notify that chat client disconnected to Server
     */
    optional func chatDidDisconnect()
    
    /**
     Method to notify that chat client reconnected to Server
     */
    optional func chatConnectionReady()
    
}