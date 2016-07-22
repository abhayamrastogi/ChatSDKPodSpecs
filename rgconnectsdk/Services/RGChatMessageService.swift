//
//  RGChatMessageService.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

public class RGChatMessageService: NSObject {
    
    private let meteorClient: MeteorClient!
    
    public init(meteorClient: MeteorClient) {
        self.meteorClient = meteorClient
        super.init()
    }
    
    /**
     Method to load Messages History for a particular Room.
     
     - parameter roomId:           Id of the Chat Room.
     - parameter untilDate:        Date Until which the messages need to be retrieved.
     - parameter numberOfMessages: Number of Messages to be retrieved.
     - parameter successCallback:  Returns a list of ChatMessage Objects.
     - parameter errorCallback:    Returns an NSError Object.
     */
    public func loadMessagesHistory(roomId: String, untilDate: NSDate = NSDate(),
                                    numberOfMessages: Int = 1000,
                                    successCallback: ((chatMessages: [ChatMessage]) -> Void),
                                    errorCallback: ((error: NSError) -> Void)) {
        
        let formData = NSDictionary(dictionary: [
            "$date": untilDate.timeIntervalSince1970*1000
            ])
        
        ChatMessageNetworkHandler.loadMessagesHistory(self.meteorClient, roomId: roomId, formData: formData, numberOfMessages: numberOfMessages, successCallback: { (chatMessages) in
            
            successCallback(chatMessages: chatMessages)
            
        }) { (error) in
            
            errorCallback(error: error)
        }
    }
    
    /**
     Method to load the Missed/Unread Messages for a particular Room
     
     - parameter roomId:          Id of the Chat Room.
     - parameter fromTimestamp:   TimeStamp of last Chat Message.
     - parameter successCallback: Returns a list of ChatMessage Objects.
     - parameter errorCallback:   Returns an NSError Object.
     */
    public func loadMissedMessages(roomId: String, fromTimestamp: Double,
                                   successCallback: ((chatMessages: [ChatMessage]) -> Void),
                                   errorCallback: ((error: NSError) -> Void)) {
        
        let formData = NSDictionary(dictionary: [
            "$date": fromTimestamp * 1000
            ])
        
        ChatMessageNetworkHandler.loadMissedMessages(self.meteorClient, roomId: roomId, formData: formData, successCallback: { (chatMessages) in
            
            successCallback(chatMessages: chatMessages)
            
        }) { (error) in
            
            errorCallback(error: error)
            
        }
    }
    
    /**
     Method to send Message to the Server.
     
     - parameter message:         Message Object to be sent to the Server. Either A Text Message or an Attachment Message.
     - parameter successCallback: Returns the response object returned from the server.
     - parameter errorCallback:   Returns an NSError Object.
     */
    public func sendMessage(message: ChatMessage,
                            successCallback: ((response: [NSObject: AnyObject]) -> Void),
                            errorCallback: ((error: NSError) -> Void)) {
        
        ChatMessageNetworkHandler.sendMessage(self.meteorClient, message: message, successCallback: { (response) in
            
            successCallback(response: response)
            
        }) { (error) in
            
            errorCallback(error: error)
            
        }
    }
    
    /**
     Method to upload file to the server
     
     - parameter roomId:          Id of the Chat Room.
     - parameter userID:          Id of the logged in user.
     - parameter fileID:          A unique ID of the file.
     - parameter fileSize:        File size of the file.
     - parameter fileData:        NSData of the file.
     - parameter fileName:        File name of the file.
     - parameter contentType:     Content type of the file.
     - parameter successCallback: Returns the response object returned from the server.
     - parameter errorCallback:   Returns an NSError Object.
     */
    public func uploadFile(roomId: String,userID:String,
                           fileID:String, fileSize:String,
                           fileData:NSData, fileName:String,contentType:String,
                           successCallback: ((response: [NSObject: AnyObject]) -> Void),
                           errorCallback: ((error: NSError) -> Void)){
        
        ChatMessageNetworkHandler.uploadFile(self.meteorClient, roomId: roomId,
                                             userID: userID, fileID: fileID,
                                             fileSize: fileSize, fileData: fileData, fileName: fileName,
                                             contentType: contentType, successCallback: { (response) in
                                            
            successCallback(response: response)
                                                
        }) { (error) in
            
            errorCallback(error: error)
        }
        
    }
}