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
        let array = ["a", "b", "c"]
        let result = CustomEncoder.encodeEither(array)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Array([.String("a"), .String("b"), .String("c")]))
    }
    
    func testEncodeObject() {
        let object = ["key": "value"]
        let result = CustomEncoder.encodeEither(object)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Object(["key": .String("value")]))
    }
    
    func testEncodeString() {
        let string = "a string"
        let result = CustomEncoder.encodeEither(string)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .String("a string"))
    }
    
    func testEncodeNumber() {
        let number = 10
        let result = CustomEncoder.encodeEither(number)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .Number(number))
    }
    
    func testEncodeError() {
        let result = CustomEncoder.encodeEither(CustomEncoder())
        XCTAssertNotNil(result)
        XCTAssertNotNil(result.left)
        XCTAssertNil(result.right)
    }
}