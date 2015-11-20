//
//  FormatterSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

public protocol CustomDateFormatJSONConvertibleType: FromJSON, ToJSON {
}

extension DateFormatJSONConvertibleType {
    public typealias T = NSDate
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSDate> {
        switch value {
        case .String(let value):
            let formatter = NSDateFormatter()
            formatter.dateFormat = DateFormatJSONFormatter.NSDateFormat
            let date = formatter.dateFromString(value)
            if let date = date {
                return .Right(date)
            }
            else {
                return .Left(.Custom("Could not format value (\(value)) to format (\(formatter.dateFormat))"))
            }
        default:
            return .Left(.TypeMismatch("NSDate format", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(date: NSDate) -> Either<JSONError, JSONValue> {
        return .Right(.String(date.description))
    }
}

struct CustomDateFormatJSONFormatter: FromJSON, ToJSON {
    typealias T = NSDate
    
    let dateFormat: String
    
    func fromJSON(value: JSONValue) -> Either<JSONError, NSDate> {
        switch value {
        case .String(let value):
            let formatter = NSDateFormatter()
            formatter.dateFormat = dateFormat
            let date = formatter.dateFromString(value)
            if let date = date {
                return .Right(date)
            }
            else {
                return .Left(.Custom("Could not format value (\(value)) to format (\(formatter.dateFormat))"))
            }
        default:
            return .Left(.TypeMismatch("NSDate format", "\(value.dynamicType.self)"))
        }
    }
    
    func toJSON(date: NSDate) -> Either<JSONError, JSONValue> {
        return .Right(.String(date.description))
    }
    
    init(dateFormat: String) {
        self.dateFormat = dateFormat
    }
}


class FormatterSpec: XCTestCase {
    func testCustomFormatter() {
    }
}