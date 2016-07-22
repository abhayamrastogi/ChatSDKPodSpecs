//
//  ChatMessageNetworkHandler.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import ObjectMapper

class ChatMessageNetworkHandler {
    
    /**
     Method to Load Messages History for a particular Room with Specified Parameters.
     
     - parameter meteorClient:     <#meteorClient description#>
     - parameter roomId:           <#roomId description#>
     - parameter formData:         <#formData description#>
     - parameter numberOfMessages: <#numberOfMessages description#>
     - parameter successCallback:  <#successCallback description#>
     - parameter errorCallback:    <#errorCallback description#>
     */
    static func loadMessagesHistory(meteorClient: MeteorClient, roomId: String,
                                    formData: NSDictionary, numberOfMessages: Int,
                                    successCallback: ((chatMessages: [ChatMessage]) -> Void),
                                    errorCallback: ((error: NSError) -> Void)) {
        
        var chatMessages = [ChatMessage]()
        meteorClient.callMethodName("loadHistory", parameters: [roomId, formData, numberOfMessages]) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                let messagesArray = (result["result"] as! [NSObject: AnyObject])["messages"] as! [NSDictionary]
                for message in messagesArray {
                    chatMessages.append(Mapper<ChatMessage>().map(message)!)
                }
                successCallback(chatMessages: chatMessages)
            }
            
        }
    }
    
    /**
     Method to Load Missed/Unread Messages for a particular Room Id.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter roomId:          <#roomId description#>
     - parameter formData:        <#formData description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func loadMissedMessages(meteorClient: MeteorClient, roomId: String, formData: NSDictionary,
                                   successCallback: ((chatMessages: [ChatMessage]) -> Void),
                                   errorCallback: ((error: NSError) -> Void)) {
        
        var chatMessages = [ChatMessage]()
        
        meteorClient.callMethodName("loadMissedMessages", parameters: [roomId, formData]) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                let messagesArray = result["result"] as! [NSDictionary]
                
                for message in messagesArray {
                    chatMessages.append(Mapper<ChatMessage>().map(message)!)
                }
                successCallback(chatMessages: chatMessages)
            }
        }
    }
    
    /**
     Method to send a particular message to the Server.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter message:         <#message description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func sendMessage(meteorClient: MeteorClient, message: ChatMessage,
                            successCallback: ((response: [NSObject: AnyObject]) -> Void),
                            errorCallback: ((error: NSError) -> Void)) {
        
        meteorClient.callMethodName("sendMessage", parameters: [message]) { (result, error) in
            
            if error != nil {
                errorCallback(error: error)
            }
            
            if result != nil {
                successCallback(response: result)
            }
        }
    }
    
    
    //MARK: File Upload
    /**
     Method to upload file to the server.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter roomId:          <#roomId description#>
     - parameter userID:          <#userID description#>
     - parameter fileID:          <#fileID description#>
     - parameter fileSize:        <#fileSize description#>
     - parameter imageData:       <#imageData description#>
     - parameter fileName:        <#fileName description#>
     - parameter contentType:     <#contentType description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    
    static func uploadFile(meteorClient: MeteorClient, roomId: String,userID:String,
                           fileID:String,fileSize:String,fileData:NSData, fileName:String,contentType:String,
                           successCallback: ((response: [NSObject: AnyObject]) -> Void),
                           errorCallback: ((error: NSError) -> Void)){
        
        let parameters:[String:AnyObject] = ["_id":fileID,"rid":roomId,"userID":userID,"name":fileName,"type":contentType,"size":fileSize,"complete":false,"uploading":true,"store":"rocketchat_uploads"]
        
        meteorClient.callMethodName("/rocketchat_uploads/insert", parameters: [parameters] , responseCallback: { (response, error) -> Void in
            
            if error != nil {
                errorCallback(error: error)
            }else{
                writeBytesToServer(meteorClient, fileData: fileData, fileID: fileID, successCallback: successCallback, errorCallback: errorCallback)
            }
        })
    }

    
    /**
     *  Calculate progress of file that is uploading to the server
     */
    struct ProgressUpdate{
        
        private var mPrg:Double?
        private var mSize:Double?
        
        mutating func progressUpdate(initCount:Double?,totalSize:Double?) {
            mPrg = initCount;
            mSize = totalSize;
        }
        
        func getProgress ()->Double{
            return mPrg!/mSize!
        }
        
        mutating func setProgress(prg:Double){
            mPrg = mPrg! + prg;
        }
    }
    
    /**
     Method to write bytes to server. Call this method in success of uploadFile method.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter fileData:        <#fileData description#>
     - parameter fileID:          <#fileID description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    
    static func writeBytesToServer(meteorClient: MeteorClient,fileData:NSData,fileID:String,
                                   successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                   errorCallback: ((error: NSError) -> Void)){
        
        let totalSizeOfBase64 : Double = Double(fileData.length)
        let chunkSize : Double = 8192
        var progressUpdate:ProgressUpdate  = ProgressUpdate(mPrg: 0, mSize: totalSizeOfBase64)
        var chunksWritten :Double = 0.0
        
        while (chunksWritten * chunkSize < totalSizeOfBase64) {
            
            let rangeValue  = NSMakeRange(Int(chunksWritten * chunkSize), min(Int(chunkSize), Int(totalSizeOfBase64 - chunksWritten * chunkSize)))
            let chunkData  = fileData.subdataWithRange(rangeValue)
            
            let chunkString = chunkData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            
            progressUpdate.setProgress(Double(chunkData.length))
            let params = [["$binary":chunkString],fileID,"rocketchat_uploads",progressUpdate.getProgress()]
            
            meteorClient.callMethodName("ufsWrite", parameters: params as [AnyObject], responseCallback: { (response, error) -> Void in
                if error != nil {
                    errorCallback(error: error)
                }else{
                    fileUploadComplete(meteorClient, fileID: fileID, successCallback: successCallback, errorCallback: errorCallback)
                }
            })
            chunksWritten = chunksWritten + 1
        }
    }
    
    /**
     Method to acknowledge the server to complete file uploading task.
     
     - parameter meteorClient:    <#meteorClient description#>
     - parameter fileID:          <#fileID description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    static func fileUploadComplete(meteorClient: MeteorClient,fileID:String,
                                   successCallback: ((response: [NSObject: AnyObject]) -> Void),
                                   errorCallback: ((error: NSError) -> Void)){
        
        meteorClient.callMethodName("ufsComplete", parameters:  [fileID,"rocketchat_uploads"] as [AnyObject], responseCallback: {
            (response, error) -> Void in
            if error != nil {
                errorCallback(error: error)
            }else{
                successCallback(response: response)
            }
        })
    }
    
}