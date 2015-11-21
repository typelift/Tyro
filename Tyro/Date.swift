//
//  Date.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct DateTimestampJSONConverter : FromJSON, ToJSON {
    public typealias T = NSDate
    
    private init() {}
    
    public static func fromJSON(value : JSONValue) -> Either<JSONError, NSDate> {
        switch value {
        case .Number(let value):
            let date = NSDate(timeIntervalSince1970 : value.doubleValue / 1000.0)
            return .Right(date)
        default:
            return .Left(.TypeMismatch("NSDate timestamp", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(date : NSDate) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedLongLong : UInt64(date.timeIntervalSince1970 * 1000.0))))
    }
}

public struct DateTimestampJSONFormatter : JSONFormatterType {
    public typealias T = DateTimestampJSONConverter.T
    private let actualJsonValue : JSONValue?
    
    public var jsonValue : JSONValue? {
        return actualJsonValue
    }
    
    init(_ jsonValue : JSONValue?) {
        actualJsonValue = jsonValue
    }
    
    init() {
        actualJsonValue = nil
    }

    public func decodeEither(value : JSONValue) -> Either<JSONError, T> {
        return DateTimestampJSONConverter.fromJSON(value)
    }

    public func encodeEither(value : T) -> Either<JSONError, JSONValue> {
        return DateTimestampJSONConverter.toJSON(value)
    }
}

public struct DateFormatJSONFormatter : JSONFormatterType {
    public typealias T = NSDate
    private let actualJsonValue : JSONValue?
    let dateFormat : String
    
    static let DefaultDateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss ZZZ"
    
    public var jsonValue : JSONValue? {
        return actualJsonValue
    }
    
    init(_ jsonValue : JSONValue?, _ dateFormat : String = DateFormatJSONFormatter.DefaultDateFormat) {
        self.dateFormat = dateFormat
        actualJsonValue = jsonValue
    }
    
    public func decodeEither(value : JSONValue) -> Either<JSONError, T> {
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
    
    public func encodeEither(value : T) -> Either<JSONError, JSONValue> {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        let string = formatter.stringFromDate(value)
        return .Right(.String(string))
    }
    
}
