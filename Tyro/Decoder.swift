//
//  Decoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONDecoderType {
    associatedtype DecodedType = AnyObject
    func decodeEither(_ value : JSONValue) -> Either<JSONError, DecodedType>
    func decode(_ value : JSONValue) -> DecodedType?
}

public class JSONDecoder : JSONDecoderType {
    public static let decoder = JSONDecoder()
    fileprivate init() {}
    
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, AnyObject> {
        switch value {
        case .Array(let values):
            
            return Either.Right( values.flatMap{ $0.anyObject } as AnyObject )
        case .Object(let value):
            return .Right(value.mapMaybe{ $0.anyObject } as AnyObject)
        case .Number(let n):
            return .Right(n)
        case .String(let s):
            return .Right(s as AnyObject)
        case .Null:
            return .Right(NSNull())
        }
    }
}

extension JSONDecoderType {
    public func decode(_ value : JSONValue) -> DecodedType? {
        return decodeEither(value).right
    }
}

extension JSONValue : JSONDecoderType {
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, JSONValue> {
        return jsonValue.toEither(.Custom("Could not decode JSONValue from JSONValue. There must be a problem."))
    }
}

extension JSONValue : JSONValueConvertible {
    public var jsonValue : JSONValue? { return self }
}
