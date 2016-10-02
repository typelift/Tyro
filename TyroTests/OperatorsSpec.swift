//
//  OperatorsSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class OperatorsSpec : XCTestCase {
    let json = "{\"bool\":true,\"intOrBool\":1,\"object\":{\"answer\":42},\"array\":[1,2,3]}"
    
    func testRetrieveJSONValue() {
        let x: JSONValue? = json.toJSONEither?.right
        XCTAssertNotNil(x)
        
        let jsonValue: JSONValue? = x <? "object"
        
        let answer: Int? = jsonValue <? "answer"
        XCTAssert(answer == 42)
    }
    
    func testRetrieve() {
        let x: JSONValue? = json.toJSONEither?.right
        XCTAssertNotNil(x)
        
        let bool: Bool? = x <? "bool"
        
        XCTAssertNotNil(bool)
        XCTAssert(bool == true)
    }
    
    func testRetrieveNested() {
        let answer: Int? = json.toJSON <? ("object" <> "answer")
        XCTAssert(answer == 42)
    }
    
    func testRetrieveOptionalSingleValue() {
        let optionalValue: Int?? = json.toJSON <?? "😎"
        XCTAssert(optionalValue! == nil)
        
        let actualValue: Bool?? = json.toJSON <?? "bool"
        XCTAssert(actualValue! == true)
        
        let ghostJsonValue: JSONValue? = nil
        let ghost: Int?? = ghostJsonValue <?? JSONKeypath.mempty
        XCTAssert(ghost! == nil)
    }
    
    func testRetrieveOptionalArray() {
        let optionalArray: [Int]?? = json.toJSON <?? "😎"
        XCTAssert(optionalArray! == nil)
        
        let actualArray: [Int]?? = json.toJSON <?? "array"
        XCTAssert(actualArray! == [1,2,3])
    }
    
    func testRetrieveOptionalObject() {
        let optionalObject: [String: Int]?? = json.toJSON <?? "😎"
        XCTAssert(optionalObject! == nil)
        
        let actualObject: [String: Int]?? = json.toJSON <?? "object"
        XCTAssert(actualObject!! == ["answer":42])
    }
    
    func testRetrieveForcedValue() {
        do {
            let value: Bool = try json.toJSON <! "bool"
            XCTAssert(value == true)
        }
        catch _ {
            XCTFail("Should have not failed with an error")
        }
        
        do {
            let _: Bool = try json.toJSON <! "😎"
            XCTFail("Should have failed with an error")
        }
        catch _ {
        }
    }
    
    func testRetrieveForcedArray() {
        do {
            let array: [Int] = try json.toJSON <! "array"
            XCTAssert(array == [1,2,3])
        }
        catch _ {
            XCTFail("Should have not failed with an error")
        }
        
        do {
            let _: [Int] = try json.toJSON <! "😎"
            XCTFail("Should have failed with an error")
        }
        catch _ {
        }
    }
    
    func testRetrieveForcedObject() {
        do {
            let value: [String: Int] = try json.toJSON <! "object"
            XCTAssert(value == ["answer":42])
        }
        catch _ {
            XCTFail("Should have not failed with an error")
        }
        
        do {
            let _: [String: Int] = try json.toJSON <! "😎"
            XCTFail("Should have failed with an error")
        }
        catch _ {
        }
    }
}
