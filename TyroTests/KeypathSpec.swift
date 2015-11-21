//
//  KeypathSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class KeypathSpec : XCTestCase {
    let dictionaryJson = "{\"object\":{\"bool\":true}}"
    
    func testKeypath() {
        let result = dictionaryJson.toJSONEither?.right
        XCTAssertNotNil(result)
        
        let bool2: Bool? = result <? "object" <> "bool"
        XCTAssertNotNil(bool2)
        XCTAssert(bool2 == true)
    }
}
