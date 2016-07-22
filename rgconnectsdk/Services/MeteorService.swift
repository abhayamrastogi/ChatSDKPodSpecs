//
//  MeteorService.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 21/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

class MeteorService {
    
    /**
     Method to initialize Meteor Client. The Meteor Client is initialized via METEOR_VERSION & DDP_ENDPOINT received from RGConnectSettings.
     
     - returns: An MeteorClient Object.
     */
    static func initializeMeteor() -> MeteorClient {
        let meteorClient = MeteorClient(DDPVersion: RGConnectSettings.METEOR_VERSION)
        meteorClient.ddp = ObjectiveDDP(URLString: "\(RGConnectSettings.BASE_URL)/websocket", delegate: meteorClient)
        meteorClient.ddp.connectWebSocket()
        return meteorClient
    }
    
    /**
     Method to add Subscriptions to Meteor Client
     
     - parameter meteorClient: Meteor Client Object.
     */
    static func addMeteorSubscriptions(meteorClient: MeteorClient) {
        for subscription in RGConnectSettings.METEOR_SUBSCRIPTIONS {
            meteorClient.addSubscription(subscription)
        }
    }
}