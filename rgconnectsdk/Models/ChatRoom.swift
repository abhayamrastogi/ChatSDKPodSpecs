//
//  ChatRoom.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 19/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

/// Model Object For Chat Room.
public class ChatRoom: Object, Mappable {
    
    public var _id: String?
    public var unread: Int?
    public var type: String?
    public var open: Bool?
    public var createdAt: Double?
    public var roomId: String?
    public var updatedAt: Double?
    public var alert: Bool?
    public var name: String?
    
    required public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init()
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    public func mapping(map: Map) {
     
        self._id    <- map["_id"]
        self.unread <- map["unread"]
        self.type   <- map["t"]
        self.open   <- map["open"]
        self.createdAt  <- map["ts"]
        self.roomId <- map["rid"]
        self.updatedAt  <- map["ls"]
        self.alert  <- map["alert"]
        self.name   <- map["name"]
    }
}