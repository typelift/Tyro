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

class DateSpec : XCTestCase {
    func testDate() {
        let timestampInMilliseconds: Double = 1443769200000
        let expectedDate = Date(timeIntervalSince1970: 1443769200000.0 / 1000.0)
        let datesJson = "{\"lastUpdated\":\(timestampInMilliseconds),\"lastUpdatedCustomFormat\":\"2015-10-02\",\"lastUpdatedThisShouldBeMillisecondsNumber\":\"2015-11-19\",\"lastUpdatedPretty\":\"2015-10-02 07:00:00 +0000\",\"lastUpdatedPrettyWrongFormat\":\"2015-10-02 07:00:00\",\"dates\":[\"2015-10-02 07:00:00 +0000\",\"2015-10-02 08:00:00 +0000\",\"2015-10-02 09:00:00 +0000\"],\"object\":{\"date\":\(timestampInMilliseconds)}}"
        let result = datesJson.toJSON
        
        XCTAssertNotNil(result)
        
        let date1: Date? = DateTimestampJSONFormatter(result) <? "lastUpdated"
        XCTAssertNotNil(date1)
        
        let date2: Date? = DateFormatJSONFormatter(result) <? "lastUpdatedPretty"
        XCTAssertNotNil(date2)
        
        let date3: Date? = DateFormatJSONFormatter(result) <? "lastUpdatedPrettyWrongFormat"
        XCTAssertNil(date3)

        let date4: Date? = DateTimestampJSONFormatter(result) <? "lastUpdatedThisShouldBeMillisecondsNumber"
        XCTAssertNil(date4)

        let date5: Date? = DateFormatJSONFormatter(result) <? "lastUpdated"
        XCTAssertNil(date5)
        
//        let dateCustomFormat: NSDate? = DateFormatJSONFormatter(result, "YYYY-MM-dd") <? "lastUpdatedCustomFormat"
//        XCTAssertNotNil(dateCustomFormat)
//        let customDate = NSDate(timeIntervalSince1970: 1443769200)
//        XCTAssert(dateCustomFormat == customDate)
        
        let dates: [Date]? = DateFormatJSONFormatter(result) <? "dates"
        XCTAssert(dates?.count == 3)
        
        let object: [String: Date]? = DateTimestampJSONFormatter(result) <? "object"
        XCTAssert(object?.keys.count == 1)
        XCTAssert(object?["date"] == expectedDate)
        
        let date = Date()
        let datesArray = [date]
        let jsonValue = DateTimestampJSONFormatter().encode(datesArray)
        let jsonString = jsonValue?.toJSONString()
        let expectedJsonString = "[\(UInt64(date.timeIntervalSince1970 * 1000.0))]"
        XCTAssert(jsonString != nil)
        XCTAssert(jsonString == expectedJsonString)
    }
}
