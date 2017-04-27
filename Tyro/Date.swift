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
    public typealias T = Date
    
    fileprivate init() {}
    
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Date> {
        switch value {
        case .Number(let value):
            let date = Date(timeIntervalSince1970 : value.doubleValue / 1000.0)
            return .Right(date)
        default:
            return .Left(.TypeMismatch("Date timestamp", "\(type(of: value).self)"))
        }
    }
    
    public static func toJSON(_ date : Date) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : UInt64(date.timeIntervalSince1970 * 1000.0))))
    }
}

public struct DateTimestampJSONFormatter : JSONFormatterType {
    public typealias T = DateTimestampJSONConverter.T
    
    public fileprivate(set) var jsonValue : JSONValue?
    
    public init(_ jsonValue : JSONValue?) {
        self.jsonValue = jsonValue
    }
    
    public init() {
        jsonValue = nil
    }
    
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, T> {
        return DateTimestampJSONConverter.fromJSON(value)
    }
    
    public func encodeEither(_ value : T) -> Either<JSONError, JSONValue> {
        return DateTimestampJSONConverter.toJSON(value)
    }
}

public struct DateFormatJSONFormatter : JSONFormatterType {
    public typealias T = Date
    
    public let dateFormat : String
    
    public static let DefaultDateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss ZZZ"
    
    public fileprivate(set) var jsonValue : JSONValue?
    
    public init(_ jsonValue : JSONValue?, _ dateFormat : String = DateFormatJSONFormatter.DefaultDateFormat) {
        self.dateFormat = dateFormat
        self.jsonValue = jsonValue
    }
    
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, T> {
        switch value {
        case .String(let value):
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            let date = formatter.date(from: value)
            if let date = date {
                return .Right(date)
            }
            else {
                return .Left(.Custom("Could not format value (\(value)) to format (\(formatter.dateFormat))"))
            }
        default:
            return .Left(.TypeMismatch("Date format", "\(type(of: value).self)"))
        }
    }
    
    public func encodeEither(_ value : T) -> Either<JSONError, JSONValue> {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let string = formatter.string(from: value)
        return .Right(.String(string))
    }
}
