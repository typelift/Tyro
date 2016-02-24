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

class TypesFromJSONSpec : XCTestCase {
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
    
//    func testIntOverflow() {
//        let max = UInt64(Int.max) + 1
//        let json = "[\(max)]"
//        let intArray: [Int]? = json.toJSON?.value()
//        XCTAssertNil(intArray)
//    }
    
//    func minMaxTest<T: NumericType where T: Bounded, T: Equatable, T: FromJSON>(type: T.Type) {
//        let min = T.minBound()
//        let max = T.maxBound()
//        let json = "{\"min\":\(min),\"max\":\(max)}"
//        let minValue: T? = json.toJSON <? "min"
//        let maxValue: T? = json.toJSON <? "max"
//        XCTAssertNotNil(min)
//        XCTAssert(minValue == min)
//        
//        XCTAssertNotNil(max)
//        XCTAssert(maxValue == max)
//    }
    
    func testInt8() {
        let min = Int8.min
        let max = Int8.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: Int8? = json.toJSON <? "min"
        let maxValue: Int8? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testInt16() {
        let min = Int16.min
        let max = Int16.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: Int16? = json.toJSON <? "min"
        let maxValue: Int16? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testInt32() {
        let min = Int32.min
        let max = Int32.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: Int32? = json.toJSON <? "min"
        let maxValue: Int32? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testInt64() {
        let min = Int64.min
        let max = Int64.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: Int64? = json.toJSON <? "min"
        let maxValue: Int64? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testUInt() {
        let min = UInt.min
        let max = UInt.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: UInt? = json.toJSON <? "min"
        let maxValue: UInt? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testUInt8() {
        let min = UInt8.min
        let max = UInt8.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: UInt8? = json.toJSON <? "min"
        let maxValue: UInt8? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testUInt16() {
        let min = UInt16.min
        let max = UInt16.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: UInt16? = json.toJSON <? "min"
        let maxValue: UInt16? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testUInt32() {
        let min = UInt32.min
        let max = UInt32.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: UInt32? = json.toJSON <? "min"
        let maxValue: UInt32? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testUInt64() {
        let min = UInt64.min
        let max = UInt64.max
        let json = "{\"min\":\(min),\"max\":\(max)}"
        let minValue: UInt64? = json.toJSON <? "min"
        let maxValue: UInt64? = json.toJSON <? "max"
        XCTAssertNotNil(min)
        XCTAssert(minValue == min)
        
        XCTAssertNotNil(max)
        XCTAssert(maxValue == max)
    }
    
    func testFloat() {
        let floatPI: Float = 3.14159
        let json = "{\"pi\":\(floatPI)}"
        let pi: Float? = json.toJSON <? "pi"
        XCTAssertNotNil(pi)
        XCTAssertEqualWithAccuracy(pi!, floatPI, accuracy: 1.0 / 1_000_000.0)
    }
    
    func testDouble() {
        let doublePI: Double = M_PI
        let json = "{\"pi\":\(doublePI)}"
        let pi: Double? = json.toJSON <? "pi"
        XCTAssertNotNil(pi)
        XCTAssertEqualWithAccuracy(pi!, doublePI, accuracy: 1.0 / 1_000_000_000_000.0)
    }
    
    func testStringFromNumber() {
        let json = "{\"id\":122585221112454722}"
        let id: UInt64? = json.toJSON <? "id"
        XCTAssertNotNil(id)
        
        let idString: String? = json.toJSON <? "id"
        XCTAssertNotNil(idString)
    }
    
    func testStringFromNumberArray() {
        let jsonNotAString = "[1]"
        let stringOfNumberArray: [String]? = jsonNotAString.toJSON?.value()
        XCTAssert(stringOfNumberArray == ["1"])
    }
    
    func testNull() {
        let json = "{\"message\":\"this is a message\",\"type\":null}"
        let jsonValueEither = JSONValue.decodeEither(json)
        let jsonValue = jsonValueEither.right
        XCTAssertTrue(jsonValue?.object != nil)
        XCTAssertTrue(jsonValue?.object?["message"] == .String("this is a message"))
        XCTAssertTrue(jsonValue?.object?["type"] == .Null)
    }
}

class TypesToJSONSpec : XCTestCase {
    func testString() {
        // TODO
    }
}
