//
//  StringExtension.swift
//  rgconnectsdk
//
//  Created by Anurag Agnihotri on 19/07/16.
//  Copyright © 2016 RoundGlass Partners. All rights reserved.
//

import Foundation

public extension String {
    
    public var nsString : NSString {
        return self as NSString
    }
    
    public var pathExtension: String? {
        return nsString.pathExtension
    }
}