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
        case let value as [AnyObject]:
            let errorValuePairs: [(JSONError?, JSONValue?)] = value.flatMap(decode).map({ (either) -> (JSONError?, JSONValue?) in
                return either.either(onLeft: { (error) -> (JSONError?, JSONValue?) in
                    return (error, nil)
                    }, onRight: { (value) -> (JSONError?, JSONValue?) in
                        return (nil, value)
                })
            })
            
            let errors: [JSONError] = errorValuePairs.flatMap { $0.0 }
            
            if errors.count > 0 {
                return .Left(.Array(errors))
            }
            else {
                return .Right(.Array(errorValuePairs.flatMap { $0.1 }))
            }
        case let value as [Swift.String: AnyObject]:
            let errorValuePairs: [(JSONError?, (Swift.String, JSONValue)?)] = value.flatMap(decode).map({ (either) -> (JSONError?, (Swift.String, JSONValue)?) in
                return either.1.either(onLeft: { (error) -> (JSONError?, (Swift.String, JSONValue)?) in
                    return (error, nil)
                    }, onRight: { (value) -> (JSONError?, (Swift.String, JSONValue)?) in
                        return (nil, (either.0, value))
                })
            })
            
            let errors: [JSONError] = errorValuePairs.flatMap { $0.0 }
            
            if errors.count > 0 {
                return .Left(.Array(errors))
            }
            else {
                let values: [Swift.String: JSONValue] = Dictionary( errorValuePairs.flatMap { $0.1 })
                return .Right(.Object(values))
            }
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