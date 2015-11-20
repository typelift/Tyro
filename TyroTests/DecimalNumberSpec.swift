//
//  DecimalNumberSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class DecimalNumberSpec: XCTestCase {
    func testDecimalNumber() {
        let jsonArray = "[102.31, 100.0, 50]"
        let array: [NSDecimalNumber]? = jsonArray.toJSON?.format(DecimalNumberJSONFormatter.self).value()
        XCTAssert(array?.count == 3)
        XCTAssert(array == [102.31, 100.0, 50])
        
        let jsonObject = "{\"account\":{\"balance\":102.31}}"
        let object: [String: NSDecimalNumber]? = jsonObject.toJSON?.format(DecimalNumberJSONFormatter.self) <? "account"
        XCTAssertNotNil(object)
        XCTAssert(object?.keys.count == 1)
        XCTAssert(object! == ["balance":102.31])
    }
}
