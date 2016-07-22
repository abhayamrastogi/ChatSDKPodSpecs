//
//  User.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

public class User: Object, Mappable  {
    
    public var userId: String?
    public var username: String?
    public var status: String?
    
    required public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    public func mapping(map: Map) {
        username    <- map["username"]
        status      <- map["status"]
    }
    
}