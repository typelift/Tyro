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

class TyroSpec : XCTestCase {
    let json = "{\"bool\":true,\"intOrBool\":1}"
    let invalidJson = "{\"bool\"\":true,\"intOrBool\":1}"
    let arrayBoolJson = "{\"bools\":[true,true,false,false]}"
    let dictionaryJson = "{\"object\":{\"bool\":true}}"
    let emojiJson = "{\"👍\":\"😎\"}"
    
    func testToJSONEither() {
        let either = json.toJSONEither
        
        XCTAssertNil(either?.left)
        XCTAssertNotNil(either?.right)
        
        XCTAssertNotNil(invalidJson.toJSONEither?.left)
    }
    
    func testToJSON() {
        let jsonValue: JSONValue? = json.toJSON
        XCTAssertNotNil(jsonValue)
        
        let invalidJsonValue: JSONValue? = invalidJson.toJSON
        XCTAssertNil(invalidJsonValue)
    }
    
    func testEitherCoalescing() {
        let result1: JSONValue? = json.toJSONEither | .Null
        let result2: JSONValue? = invalidJson.toJSONEither | .Null
        XCTAssert(result1 != .Null)
        XCTAssert(result2 == .Null)
        
        let result3: JSONValue? = json.toJSONEither | nil
        let result4: JSONValue? = invalidJson.toJSONEither | nil
        XCTAssert(result3 != nil)
        XCTAssertNil(result4)
    }
    
    func testSubscript() {
        let either = json.toJSONEither
        let jsonValue = either?.right?["bool"]
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == JSONValue.Number(true))
    }
    
    func testValue() {
        let either = json.toJSONEither
        XCTAssertNotNil(either?.right)
        
        let bool: Bool? = either?.right?["bool"]?.value()
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
        
        let intOrBool: Int? = either?.right?["intOrBool"]?.value()
        XCTAssertNotNil(intOrBool)
        XCTAssert(intOrBool == 1)
    }
    
    func testValueArray() {
        let result = arrayBoolJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let jsonValue: JSONValue? = result?["bools"]
        let bools: [Bool]? = jsonValue?.value()
        
        XCTAssertNotNil(bools)
        XCTAssert(bools?.count == 4)
        XCTAssert(bools == [true, true, false, false])
    }
    
    func testValueDictionary() {
        let result = dictionaryJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let object: [String: Bool]? = result <? "object"
        XCTAssertNotNil(object)
        XCTAssert(object?["bool"] == true)
        
        let bool1: Bool? = result?["object"]?["bool"]?.value()
        
        XCTAssertNotNil(bool1)
        XCTAssert(bool1 == true)
    }
    
    func testEmoji() {
        let emoji: String? = emojiJson.toJSON <? "👍"
        XCTAssert(emoji == "😎")
    }
}

internal func == <Element : Equatable>(lhs : [Element]?, rhs : [Element]) -> Bool {
	if let lhs = lhs {
		return lhs == rhs
	}
	else {
		return false
	}
}
