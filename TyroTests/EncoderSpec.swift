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

class EncoderSpec: XCTestCase {
    func testEncodeArray() {
        let array = ["a", "b", "c"]
        let result = JSONEncoder.encoder.encodeEither(array)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Array([.String("a"), .String("b"), .String("c")]))
    }
    
    func testEncodeObject() {
        let object = ["key": "value"]
        let result = JSONEncoder.encoder.encodeEither(object)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Object(["key": .String("value")]))
    }
    
    func testEncodeString() {
        let string = "a string"
        let result = JSONEncoder.encoder.encodeEither(string)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .String("a string"))
    }
    
    func testEncodeNumber() {
        let number = 10
        let result = JSONEncoder.encoder.encodeEither(number)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .Number(number))
    }
    
    func testEncodeError() {
        let result = JSONEncoder.encoder.encodeEither(JSONEncoder.encoder)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result.left)
        XCTAssertNil(result.right)
    }
}