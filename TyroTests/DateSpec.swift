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
        let datesJson = "{\"int\":42,\"lastUpdated\":\(timestampInMilliseconds),\"lastUpdatedThisShouldBeMillisecondsNumber\":\"2015-11-19\",\"lastUpdatedPretty\":\"2015-10-02 07:00:00 +0000\",\"lastUpdatedPrettyWrongFormat\":\"2015-10-02 07:00:00\",\"dates\":[\"2015-10-02 07:00:00 +0000\",\"2015-10-02 08:00:00 +0000\",\"2015-10-02 09:00:00 +0000\"],\"object\":{\"date\":\(timestampInMilliseconds)}}"
        let result = datesJson.toJSON
        
        XCTAssertNotNil(result)
        
//        let int: Int? = result?.format(DateTimestampJSONFormatter.self) <? "int"
//        XCTAssert(int == 42)
        
        let date1: NSDate? = result?.format(DateTimestampJSONFormatter.self) <? "lastUpdated"
        XCTAssertNotNil(date1)
        
        let date2: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdatedPretty"
        XCTAssertNotNil(date2)
        
        let date3: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdatedPrettyWrongFormat"
        XCTAssertNil(date3)

        let date4: NSDate? = result?.format(DateTimestampJSONFormatter.self) <? "lastUpdatedThisShouldBeMillisecondsNumber"
        XCTAssertNil(date4)

        let date5: NSDate? = result?.format(DateFormatJSONFormatter.self) <? "lastUpdated"
        XCTAssertNil(date5)
        
        let dates: [NSDate]? = result?.format(DateFormatJSONFormatter.self) <? "dates"
        XCTAssert(dates?.count == 3)
        
        let object: [String: NSDate]? = result?.format(DateTimestampJSONFormatter.self) <? "object"
        XCTAssert(object?.keys.count == 1)
        XCTAssert(object?["date"] == expectedDate)
        
//        let date = NSDate()
//        let datesArray = [date]
//        let jsonString = JSONValue.encode(datesArray)?.format(DateTimestampJSONFormatter.self).jsonValue?.toJSONString()
//        XCTAssert(jsonString != nil)
//        XCTAssert(jsonString == "[\(date.timeIntervalSince1970 * 1000.0)]")
    }
}