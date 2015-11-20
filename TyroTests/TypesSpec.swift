//
//  TypesSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class TypesFromJSONSpec: XCTestCase {
    func testString() {
        let jsonStringInArray = "[\"This is a string\",\"\"]"
        let stringInArray: [String]? = jsonStringInArray.toJSON?.value()
        XCTAssert(stringInArray?.count == 2)
        XCTAssert(stringInArray?[0] == "This is a string")
        XCTAssert(stringInArray?[1] == "")
        
        let jsonStringInObject = "{\"string\":\"This is a string\"}"
        let stringFromObject: String? = jsonStringInObject.toJSON <? "string"
        XCTAssert(stringFromObject == "This is a string")
    }
    
    func testStringInvalid() {
        let jsonNotAString = "[1]"
        let notAStringArray: [String]? = jsonNotAString.toJSON?.value()
        XCTAssertNil(notAStringArray)
    }
    
    func testBool() {
        let jsonBoolInArray = "[true,false]"
        let boolInArray: [Bool]? = jsonBoolInArray.toJSON?.value()
        XCTAssert(boolInArray?.count == 2)
        XCTAssert(boolInArray?[0] == true)
        XCTAssert(boolInArray?[1] == false)
        
        let jsonBoolInObject = "{\"boolTrue\":true,\"boolFalse\":false}"
        let boolTrue: Bool? = jsonBoolInObject.toJSON <? "boolTrue"
        let boolFalse: Bool? = jsonBoolInObject.toJSON <? "boolFalse"
        XCTAssert(jsonBoolInObject.toJSON?.object?.keys.count == 2)
        XCTAssert(boolTrue == true)
        XCTAssert(boolFalse == false)
    }
    
    func testBoolInvalid() {
        let jsonNotABool = "[2]"
        let notABoolArray: [Bool]? = jsonNotABool.toJSON?.value()
        XCTAssertNil(notABoolArray)
    }
    
    func testInt() {
        let jsonIntInArray = "[1,2]"
        let intInArray: [Int]? = jsonIntInArray.toJSON?.value()
        XCTAssert(intInArray?.count == 2)
        XCTAssert(intInArray?[0] == 1)
        XCTAssert(intInArray?[1] == 2)
        
        let jsonIntInObject = "{\"int1\":1,\"nestedInt\":{\"answer\":42}}"
        let int1: Int? = jsonIntInObject.toJSON <? "int1"
        let answer: Int? = jsonIntInObject.toJSON <? "nestedInt" <> "answer"
        XCTAssert(jsonIntInObject.toJSON?.object?.keys.count == 2)
        XCTAssert(int1 == 1)
        XCTAssert(answer == 42)
    }
    
    func testIntInvalid() {
        let jsonNotAInt = "[\"\"]"
        let notAIntArray: [Int]? = jsonNotAInt.toJSON?.value()
        XCTAssertNil(notAIntArray)
    }
    
    func testIntOverflow() {
        let max = UInt64(Int.max) + 1
        let json = "[\(max)]"
        let intArray: [Int]? = json.toJSON?.value()
        XCTAssertNil(intArray)
    }
    
    func testInt8() {
//        let jsonInt8InArray = "
    }
}

class TypesToJSONSpec: XCTestCase {
    func testString() {
        // TODO
    }
}