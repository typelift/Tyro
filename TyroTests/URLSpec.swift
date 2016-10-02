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

class URLSpec : XCTestCase {
    func testURL() {
        let json = "{\"url\":\"https://github.com/mpurland\"}"
        let url: URL? = URLJSONFormatter(json.toJSON) <? "url"
        XCTAssertNotNil(url)
        XCTAssert(url == URL(string: "https://github.com/mpurland"))
    }
}
