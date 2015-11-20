//
//  EncoderSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class CustomEncoder {
}

extension CustomEncoder: JSONEncoder {}

class EncoderSpec: XCTestCase {
    func testEncodeArray() {
        let jsonArray = JSONValue.Array([.String("a")])
        let arrayObject = CustomEncoder.encode(jsonArray).right
        let arrayStrings: [String]? = arrayObject as? [String]
        XCTAssert(arrayStrings == ["a"])
    }
    
    func testEncodeObject() {
        let jsonObject = JSONValue.Object(["key": .String("value")])
        let object = CustomEncoder.encode(jsonObject).right
        let dictionary: [String: String]? = object as? [String: String]
        XCTAssert(dictionary! == ["key": "value"])
    }
    
    func testEncodeString() {
        let jsonString = JSONValue.String("a")
        let stringObject = CustomEncoder.encode(jsonString).right
        let string: String? = stringObject as? String
        XCTAssert(string == "a")
    }
    
    func testEncodeNumber() {
        let jsonNumber = JSONValue.Number(42)
        let numberObject = CustomEncoder.encode(jsonNumber).right
        let number: NSNumber? = numberObject as? NSNumber
        XCTAssert(number == 42)
    }
    
    func testEncodeNull() {
        let jsonNull = JSONValue.Null
        let nullObject = CustomEncoder.encode(jsonNull).right
        let null: NSNull? = nullObject as? NSNull
        XCTAssertNotNil(null) // P = NP?
    }
}
