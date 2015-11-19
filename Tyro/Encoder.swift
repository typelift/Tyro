//
//  Encoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

internal func convertAnyObject<A>(type: A) -> AnyObject? {
    return type as? AnyObject
}

public protocol JSONEncoder {
    static func encode(value: JSONValue) -> Either<JSONError, AnyObject>
}

extension JSONEncoder {
    public static func encode(value: JSONValue) -> Either<JSONError, AnyObject> {
        switch value {
        case .Array(let values):
            return .Right(values.flatMap(convertAnyObject))
        case .Object(let value):
            return .Right(value.flatMap(convertAnyObject))
        case .Number(let n):
            return .Right(n)
        case .String(let s):
            return .Right(s)
        case .Null:
            return .Right(NSNull())
        }
    }
}

extension JSONValue: JSONEncoder {}