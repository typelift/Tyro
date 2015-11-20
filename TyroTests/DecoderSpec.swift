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
        let array = ["a", "b", "c"]
        let result = CustomDecoder.decode(array)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Array([.String("a"), .String("b"), .String("c")]))
    }
    
    func testDecodeObject() {
        let object = ["key": "value"]
        let result = CustomDecoder.decode(object)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Object(["key": .String("value")]))
    }
    
    func testDecodeString() {
        let string = "a string"
        let result = CustomDecoder.decode(string)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .String("a string"))
    }
    
    func testDecodeNumber() {
        let number = 10
        let result = CustomDecoder.decode(number)
        XCTAssertNotNil(result)
        XCTAssert(result.right == .Number(number))
    }
    
    func testDecodeError() {
        let result = CustomDecoder.decode(CustomDecoder())
        XCTAssertNotNil(result)
        XCTAssertNotNil(result.left)
        XCTAssertNil(result.right)
    }
}
