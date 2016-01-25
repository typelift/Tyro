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

class EncoderSpec : XCTestCase {
    func testEncodeArray() {
        let array = ["a", "b", "c"]
        let result = JSONEncoder.encoder.encodeEither(array)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Array([.String("a"), .String("b"), .String("c")]))
        let jsonString = result.right!.toJSONString()!
        print("testEncodeArray: \(jsonString)")
        XCTAssertEqual("[\"a\",\"b\",\"c\"]", jsonString)
    }
    
    func testEncodeObject() {
        let object = ["key": "value"]
        let result = JSONEncoder.encoder.encodeEither(object)
        XCTAssertNotNil(result)
        XCTAssert(result.right == JSONValue.Object(["key": .String("value")]))
        let jsonString = result.right!.toJSONString()!
        print("testEncodeObject: \(jsonString)")
        XCTAssertEqual("{\"key\":\"value\"}", jsonString)
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
    
    func testEncodeEmbeddedObjects() {
        let object = ["number": 42, "array": [1, 2, 3], "object": ["strings": ["1", "2", "3"], "pi": 3.14159], "string": "hello"]
        let result = JSONEncoder.encoder.encodeEither(object)
        XCTAssertNotNil(result)
        
        switch result.right! {
        case .Object(let v):
            XCTAssert(result.right == .Object(v))
            XCTAssert(v["number"] == .Number(42))
            XCTAssert(v["string"] == .String("hello"))
            XCTAssert(v["array"] == .Array([.Number(1), .Number(2), .Number(3)]))
            XCTAssert(v["object"] == .Object(["strings": .Array([.String("1"), .String("2"), .String("3")]), "pi": .Number(3.14159)]))
            let jsonString = result.right!.toJSONString()!
            print("testEncodeEmbeddedObjects: \(jsonString)")
            let expectedJson = "{\"array\":[1,2,3],\"object\":{\"strings\":[\"1\",\"2\",\"3\"],\"pi\":3.14159},\"number\":42,\"string\":\"hello\"}"
            XCTAssertEqual(expectedJson, jsonString)
        default:
            XCTFail("Could not encode to JSONValue.Object")
        }
    }
    
    func testEncodeError() {
        let result = JSONEncoder.encoder.encodeEither(JSONEncoder.encoder)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result.left)
        XCTAssertNil(result.right)
    }
}
