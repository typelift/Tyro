//
//  EnumSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

enum StatusType: String {
    case Passed = "passed"
    case Invalid = "invalid"
}

enum HttpErrorCodeType: Int {
    case ok = 200
    case notFound = 404
}

extension StatusType: FromJSON, ToJSON {}

extension HttpErrorCodeType: FromJSON, ToJSON {}

class EnumSpec : XCTestCase {
    func testEnum() {
        let json = "{\"statusCode\":200,\"status\":\"passed\"}"
        let statusCode: HttpErrorCodeType? = json.toJSON <? "statusCode"
        XCTAssertNotNil(statusCode)
        XCTAssert(statusCode == .ok)
        
        let status: StatusType? = json.toJSON <? "status"
        XCTAssertNotNil(status)
        XCTAssert(status == .Passed)
    }
    
    func testEnumNotMapped() {
        let json = "{\"statusCode\":201}"
        let statusCode: HttpErrorCodeType? = json.toJSON <? "statusCode"
        XCTAssertNil(statusCode)
    }
    
    func testEnumWrongType() {
        let json = "{\"statusCode\":\"this is not a number\",\"status\":200}"
        let statusCode: HttpErrorCodeType? = json.toJSON <? "statusCode"
        XCTAssertNil(statusCode)
        
        let status: StatusType? = json.toJSON <? "status"
        XCTAssertNil(status)
    }
    
    func testEncodeEnum() {
        let dictionary: [String: StatusType] = ["status": .Passed]
        let json = JSONValue.encode(dictionary)?.toJSONString()
        let expectedJson = "{\"status\":\"passed\"}"
        XCTAssert(json == expectedJson)
        
        let jsonData = JSONValue.encode(dictionary)?.toJSONData()
        XCTAssert(jsonData != nil)
        XCTAssert(jsonData?.toUTF8String() == expectedJson)
    }
}
