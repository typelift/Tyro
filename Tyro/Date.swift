//
//  Date.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol DateTimestampJSONConvertibleType: FromJSON, ToJSON {
}

extension DateTimestampJSONConvertibleType {
    public typealias T = NSDate
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSDate> {
//        print("value: \(value)")
        switch value {
        case .Number(let value):
            let date = NSDate(timeIntervalSince1970: value.doubleValue / 1000.0)
            return .Right(date)
        default:
            return .Left(.TypeMismatch("NSDate timestamp", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(date: NSDate) -> Either<JSONError, JSONValue> {
        return .Right(.Number(date.timeIntervalSince1970 * 1000.0))
    }
}

struct DateTimestampJSONFormatter: DateTimestampJSONConvertibleType {
    private init() {}
}

public protocol DateFormatJSONConvertibleType: FromJSON, ToJSON {
}

extension DateFormatJSONConvertibleType {
    public typealias T = NSDate
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSDate> {
//        print("value: \(value)")
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

struct DateFormatJSONFormatter: DateFormatJSONConvertibleType {
    static let NSDateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss ZZZ"
    
    private init() {}
}