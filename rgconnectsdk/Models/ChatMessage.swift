//
//  ChatMessage.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 19/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

/// Object For Chat Messages.

public class ChatMessage: Object, Mappable {
    
    public dynamic var roomId: String!
    public dynamic var userId: String!
    public dynamic var username: String!
    public dynamic var message: String!
    public dynamic var messageType: String!
    public dynamic var timestamp: Double = 0.0
    public dynamic var gifUrl: String?
    public dynamic var imageFileUrl: String?
    public dynamic var imageTitle: String?
    public dynamic var pdfTitle: String?
    public dynamic var pdfLink: String?
    
    private var attachments = List<ChatMessageAttachment>()
    
    required public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init()
    }
    
    public func mapping(map: Map) {
        
        self.roomId         <- map["rid"]
        self.userId         <- map["u._id"]
        self.username       <- map["u.username"]
        self.message        <- map["msg"]
        self.messageType    <- map["t"]
        self.timestamp      <- map["ts.$date"]
        
        self.attachments    <- map["attachments"]
        self.populateAttachmentFields(attachments.first)
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    /**
     Method to Populate Attachment Fields for the Chat Message.
     
     - parameter attachment: Chat Message Attachment Object.
     */
    private func populateAttachmentFields(attachment: ChatMessageAttachment?) {
        if let imageUrl = attachment?.imageUrl {
            
            if imageUrl.pathExtension?.lowercaseString == "gif" {
                self.gifUrl = imageUrl
            } else {
                self.imageFileUrl = imageUrl
            }
            
            self.imageTitle = attachment?.title
       
        } else if let fileLink = attachment?.fileLink {
            
            if fileLink.pathExtension?.lowercaseString == "pdf" {
                self.pdfLink = fileLink
                self.pdfTitle = attachment?.title
            }

        }
    }
    
    /// Chat Message Attachment Object to handle different types of attachments.
    
    private class ChatMessageAttachment: Object, Mappable {
        
        dynamic var imageUrl: String?
        dynamic var fileLink: String?
        dynamic var title: String?
        
        required init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init()
        }
        
        
        required init(value: AnyObject, schema: RLMSchema) {
            super.init(value: value, schema: schema)
        }
        
        required init(realm: RLMRealm, schema: RLMObjectSchema) {
            super.init(realm: realm, schema: schema)
        }
        
        private func mapping(map: Map) {
            imageUrl <- map["imageUrl"]
            fileLink <- map["fileLink"]
            title    <- map["title"]
        }
    }
}
