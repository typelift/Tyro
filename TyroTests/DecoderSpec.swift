//
//  DecoderSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class CustomDecoder {
}

extension CustomDecoder: JSONDecoder {}

class DecoderSpec: XCTestCase {
    func testDecodeArray() {
        let jsonArray = JSONValue.Array([.String("a")])
        let arrayObject = CustomDecoder.decodeEither(jsonArray).right
        let arrayStrings: [String]? = arrayObject as? [String]
        XCTAssert(arrayStrings == ["a"])
    }
    
    func testDecodeObject() {
        let jsonObject = JSONValue.Object(["key": .String("value")])
        let object = CustomDecoder.decodeEither(jsonObject).right
        let dictionary: [String: String]? = object as? [String: String]
        XCTAssert(dictionary! == ["key": "value"])
    }
    
    func testDecodeString() {
        let jsonString = JSONValue.String("a")
        let stringObject = CustomDecoder.decodeEither(jsonString).right
        let string: String? = stringObject as? String
        XCTAssert(string == "a")
    }
    
    func testDecodeNumber() {
        let jsonNumber = JSONValue.Number(42)
        let numberObject = CustomDecoder.decodeEither(jsonNumber).right
        let number: NSNumber? = numberObject as? NSNumber
        XCTAssert(number == 42)
    }
    
    func testDecodeNull() {
        let jsonNull = JSONValue.Null
        let nullObject = CustomDecoder.decodeEither(jsonNull).right
        let null: NSNull? = nullObject as? NSNull
        XCTAssertNotNil(null) // P = NP?
    }
}
