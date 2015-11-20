//
//  DateSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class DateSpec: XCTestCase {
    func testDate() {
        let timestampInMilliseconds: Double = 1443769200000
        let expectedDate = NSDate(timeIntervalSince1970: 1443769200000.0 / 1000.0)
        let datesJson = "{\"lastUpdated\":\(timestampInMilliseconds),\"lastUpdatedPretty\":\"2015-10-02 07:00:00 +0000\",\"dates\":[\"2015-10-02 07:00:00 +0000\",\"2015-10-02 08:00:00 +0000\",\"2015-10-02 09:00:00 +0000\"],\"object\":{\"date\":\(timestampInMilliseconds)}}"
        let result = datesJson.toJSONEither?.right
        
        XCTAssertNotNil(result)
        
        let date1: NSDate? = result?.format(DateTimestampJSONFormatter.self) <? "lastUpdated"
        XCTAssertNotNil(date1)
        
        let date2: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdatedPretty"
        XCTAssertNotNil(date2)
        
        let dates: [NSDate]? = result?.format(DateFormatJSONFormatter.self) <? "dates"
        XCTAssert(dates?.count == 3)
        
        let object: [String: NSDate]? = result?.format(DateTimestampJSONFormatter.self) <? "object"
        XCTAssert(object?.keys.count == 1)
        XCTAssert(object?["date"] == expectedDate)
    }
}