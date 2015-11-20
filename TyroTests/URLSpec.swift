//
//  URLSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class URLSpec: XCTestCase {
    func testURL() {
        let json = "{\"url\":\"https://github.com/mpurland\"}"
        let url: NSURL? = json.toJSON?.format(URLJSONFormatter.self) <? "url"
        XCTAssertNotNil(url)
        XCTAssert(url == NSURL(string: "https://github.com/mpurland"))
    }
}