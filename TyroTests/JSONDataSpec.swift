//
//  JSONDataSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import XCTest
import Swiftz
@testable import Tyro

struct BufferFriend {
    let id: Int
    let name: String
}

struct Buffer {
    let id: String
    let index: Int
    let guid: String
    let active: Bool
    let balance: NSDecimalNumber
    let picture: String
    let age: Int
    let eyeColor: String
    let name: String
    let gender: String
    let company: String
    let email: String
    let phone: String
    let address: String
    let about: String
    let registered: Date
    let latitude: Double
    let longitude: Double
    let tags: [String]
    let friends: [BufferFriend]
}

class JSONDataSpec : XCTestCase {
    func testBufferBuilder() {
        
    }
    
    func testDatesFract() {
    }
    
    func testExample() {
    }
    
    func testGeometry() {
    }
    
    func testIntegers() {
    }
    
    func testJp10() {
    }
    
    func testJp50() {
    }
    
    func testJp100() {
    }
    
    func testNumbers() {
    }
    
    func testTwitter1() {
    }
    
    func testTwitter10() {
    }
    
    func testTwitter20() {
    }
    
    func testTwitter50() {
    }
    
    func testTwitter100() {
    }
}
