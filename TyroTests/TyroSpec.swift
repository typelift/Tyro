//
//  TyroSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/18/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

extension String {
    func deserializeJson() -> Either<JSONError, JSONValue>? {
        return JSONValue.deserialize <^> self
    }
}

extension NSDate: FromJSON {
    public typealias T = NSDate
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSDate> {
        return .Left(.TypeMismatch("", ""))
    }
}

class TyroSpec: XCTestCase {
    let json = "{\"bool\":true,\"intOrBool\":1}"
    let invalidJson = "{\"bool\"\":true,\"intOrBool\":1}"
    let arrayBoolJson = "{\"bools\":[true,true,false,false]}"
    let dictionaryJson = "{\"object\":{\"bool\":true}}"
    
    func testEither() {
        let either = json.deserializeJson()
        
        XCTAssertNil(either?.left)
        XCTAssertNotNil(either?.right)
        
        XCTAssertNotNil((JSONValue.deserialize <^> invalidJson)?.left)
    }
    
    func testEitherCoalescing() {
        let result1: JSONValue? = json.deserializeJson() | .Null
        let result2: JSONValue? = invalidJson.deserializeJson() | .Null
        XCTAssert(result1 != .Null)
        XCTAssert(result2 == .Null)
    }
    
    func testSubscript() {
        let either = json.deserializeJson()
        let jsonValue = either?.right?["bool"]
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == JSONValue.Number(true))
    }
    
    func testValue() {
        let either = json.deserializeJson()
        XCTAssertNotNil(either?.right)
        
        let bool: Bool? = either?.right?["bool"]?.value()
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
        
        let intOrBool: Int? = either?.right?["intOrBool"]?.value()
        XCTAssertNotNil(intOrBool)
        XCTAssert(intOrBool == 1)
    }
    
    func testValueArray() {
        let either = arrayBoolJson.deserializeJson()
        XCTAssertNotNil(either?.right)
        let jsonValue: JSONValue? = either?.right?["bools"]
        let bools: [Bool]? = jsonValue?.value()
        
        XCTAssertNotNil(bools)
        XCTAssert(bools?.count == 4)
        XCTAssert(bools! == [true, true, false, false])
    }
    
    func testValueDictionary() {
        let result = dictionaryJson.deserializeJson()?.right
        XCTAssertNotNil(result)
        
        let object: [String: Bool]? = result <? "object"
        XCTAssertNotNil(object)
        XCTAssert(object?["bool"] == true)
        
        let bool1: Bool? = result?["object"]?["bool"]?.value()
        
        XCTAssertNotNil(bool1)
        XCTAssert(bool1 == true)
    }
    
    func testKeypath() {
        let result = dictionaryJson.deserializeJson()?.right
        XCTAssertNotNil(result)
        
        let bool2: Bool? = result <? "object" <> "bool"
        XCTAssertNotNil(bool2)
        XCTAssert(bool2 == true)
    }
    
    func testOperatorRetrieve() {
        let x: JSONValue? = json.deserializeJson()?.right
        XCTAssertNotNil(x)
        
        let bool: Bool? = x <? "bool"
        
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
    }
    
    func testDate() {
        let timestampInMilliseconds: Double = 1443769200000
        let json = "{\"lastUpdated\":\(timestampInMilliseconds),\"lastUpdatedPretty\":\"2015-10-02 07:00:00 +0000\"}"
        let result = json.deserializeJson()?.right
        
        XCTAssertNotNil(result)
        
        let date1: NSDate? = result?.format(DateTimestampJSONFormatter.self) <? "lastUpdated"
        XCTAssertNotNil(date1)
        
        let date2: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdatedPretty"
        XCTAssertNotNil(date2)
    }
}