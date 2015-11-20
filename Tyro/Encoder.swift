//
//  Encoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONEncoder {
    static func encode(value: AnyObject) -> Either<JSONError, JSONValue>
    
    /// Extra decoders for native types that are not of type AnyObject
    static func encode<A: ToJSON where A.T == A>(value: A) -> Either<JSONError, JSONValue>
    static func encode<A: ToJSON where A.T == A>(value: [A]) -> Either<JSONError, JSONValue>
    static func encode<A: ToJSON where A.T == A>(value: [Swift.String: A]) -> Either<JSONError, JSONValue>
}

extension JSONEncoder {
    public static func encode(value: AnyObject) -> Either<JSONError, JSONValue> {
        switch value {
        case let values as [AnyObject]:
            return values.flatMap(encode).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
        case let value as [Swift.String: AnyObject]:
            return value.flatMap(encode).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
        case let value as Swift.String:
            return .Right(.String(value))
        case let value as NSNumber:
            return .Right(.Number(value))
        default:
            // This should never happen...
            return .Left(.Custom("Could not match type for value: \(value)"))
        }
    }
    
    public static func encode<A: ToJSON where A.T == A>(value: A) -> Either<JSONError, JSONValue> {
        return A.toJSON(value)
    }
    
    public static func encode<A: ToJSON where A.T == A>(value: [A]) -> Either<JSONError, JSONValue> {
        return value.flatMap(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }
    
    public static func encode<A: ToJSON where A.T == A>(value: [Swift.String: A]) -> Either<JSONError, JSONValue> {
        return value.flatMap(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }
}

extension JSONValue: JSONEncoder {}