//
//  Decoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONDecoder {
    static func decode(value: JSONValue) -> Either<JSONError, AnyObject>
}

extension JSONDecoder {
    public static func decode(value: JSONValue) -> Either<JSONError, AnyObject> {
        switch value {
        case .Array(let values):
            return .Right(values.flatMap { $0.anyObject })
        case .Object(let value):
            return .Right(value.flatMap { $0.anyObject })
        case .Number(let n):
            return .Right(n)
        case .String(let s):
            return .Right(s)
        case .Null:
            return .Right(NSNull())
        }
    }
}

extension JSONValue: JSONDecoder {}