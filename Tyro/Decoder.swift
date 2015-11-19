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
    static func decode(value: AnyObject) -> Either<JSONError, JSONValue>
}

extension JSONDecoder {
    public static func decode(value: AnyObject) -> Either<JSONError, JSONValue> {
        switch value {
        case let values as [AnyObject]:
            return values.flatMap(decode).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
        case let value as [Swift.String: AnyObject]:
            return value.flatMap(decode).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
        case let value as Swift.String:
            return .Right(.String(value))
        case let value as NSNumber:
            return .Right(.Number(value))
        default:
            return .Left(.Custom("Could not match type for value: \(value)"))
        }
    }
}

extension JSONValue: JSONDecoder {}