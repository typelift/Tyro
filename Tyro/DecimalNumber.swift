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
    
    private init() {}
    
    public static func fromJSON(value : JSONValue) -> Either<JSONError, NSDecimalNumber> {
        switch value {
        case .Number(let n):
            return .Right(NSDecimalNumber(decimal : n.decimalValue))
        default:
            return .Left(.TypeMismatch("NSDecimalNumber JSON", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(dn : NSDecimalNumber) -> Either<JSONError, JSONValue> {
        return .Right(.Number(dn))
    }
}

public struct DecimalNumberJSONFormatter : JSONFormatterType {
    public typealias T = DecimalNumberJSONConverter.T
    
    public private(set) var jsonValue : JSONValue?
    
    public init(_ jsonValue : JSONValue?) {
        self.jsonValue = jsonValue
    }
    
    public func decodeEither(value : JSONValue) -> Either<JSONError, T> {
        return DecimalNumberJSONConverter.fromJSON(value)
    }
    
    public func encodeEither(value : T) -> Either<JSONError, JSONValue> {
        return DecimalNumberJSONConverter.toJSON(value)
    }
}
