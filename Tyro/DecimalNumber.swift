//
//  DecimalNumber.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct DecimalNumberJSONConverter : FromJSON, ToJSON {
    public typealias T = NSDecimalNumber
    
    fileprivate init() {}
    
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, NSDecimalNumber> {
        switch value {
        case .Number(let n):
            return .Right(NSDecimalNumber(decimal : n.decimalValue))
        default:
            return .Left(.TypeMismatch("DecimalNumber JSON", "\(type(of: value).self)"))
        }
    }
    
    public static func toJSON(_ dn : NSDecimalNumber) -> Either<JSONError, JSONValue> {
        return .Right(.Number(dn))
    }
}

public struct DecimalNumberJSONFormatter : JSONFormatterType {

    public typealias T = DecimalNumberJSONConverter.T
    
    public fileprivate(set) var jsonValue : JSONValue?
    
    public init(_ jsonValue : JSONValue?) {
        self.jsonValue = jsonValue
    }
    
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, T> {
        return DecimalNumberJSONConverter.fromJSON(value)
    }
    
    public func encodeEither(_ value : T) -> Either<JSONError, JSONValue> {
        return DecimalNumberJSONConverter.toJSON(value)
    }
    
}
