//
//  Encoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONEncoderType {
    associatedtype EncodedType = AnyObject
    func encodeEither(value : EncodedType) -> Either<JSONError, JSONValue>
    func encode(value : EncodedType) -> JSONValue?
    
    func encodeEither(value : [EncodedType]) -> Either<JSONError, JSONValue>
    func encode(value : [EncodedType]) -> JSONValue?

    func encodeEither(value : [String : EncodedType]) -> Either<JSONError, JSONValue>
    func encode(value : [String : EncodedType]) -> JSONValue?
}

extension JSONEncoderType {
    public func encodeEither(value : [EncodedType]) -> Either<JSONError, JSONValue> {
        return value.flatMap(self.encodeEither).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }

    public func encodeEither(value : [String : EncodedType]) -> Either<JSONError, JSONValue> {
        return value.mapMaybe(self.encodeEither).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }

    public func encode(value : EncodedType) -> JSONValue? {
        return encodeEither(value).right
    }
    
    public func encode(value : [EncodedType]) -> JSONValue? {
        return encodeEither(value).right
    }
    
    public func encode(value : [String : EncodedType]) -> JSONValue? {
        return encodeEither(value).right
    }
}

public class JSONEncoder : JSONEncoderType {
    public static let encoder = JSONEncoder()
    private init() {}
    
    public func encodeEither(value : AnyObject) -> Either<JSONError, JSONValue> {
        switch value {
        case let values as [AnyObject]:
            return encodeEither(values)
        case let value as [Swift.String : AnyObject]:
            return encodeEither(value)
        case let value as Swift.String :
            return .Right(.String(value))
        case let value as NSNumber :
            return .Right(.Number(value))
        case _ as NSNull :
            return .Right(.Null)
        default:
            // This should never happen...
            return .Left(.Custom("Could not match type for value : \(value)"))
        }
    }
    
    public func encode(value : AnyObject) -> JSONValue? {
        return encodeEither(value).right
    }
}

/// Extra decoders for native types that are not of type AnyObject
extension JSONEncoderType {
    public static func encodeEither<A : ToJSON where A.T == A>(value : A) -> Either<JSONError, JSONValue> {
        return A.toJSON(value)
    }
    
    public static func encodeEither<A : ToJSON where A.T == A>(value : [A]) -> Either<JSONError, JSONValue> {
        return value.flatMap(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }
    
    public static func encodeEither<A : ToJSON where A.T == A>(value : [Swift.String : A]) -> Either<JSONError, JSONValue> {
        return value.mapMaybe(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : A) -> JSONValue? {
        return encodeEither(value).right
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : [A]) -> JSONValue? {
        return encodeEither(value).right
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : [Swift.String : A]) -> JSONValue? {
        return encodeEither(value).right
    }
}

extension JSONValue : JSONEncoderType {
    public typealias EncodedType = AnyObject
    
    public func encodeEither(value : EncodedType) -> Either<JSONError, JSONValue> {
        return JSONEncoder.encoder.encodeEither(value)
    }
    
    public func encode(value : AnyObject) -> JSONValue? {
        return JSONEncoder.encoder.encode(value)
    }

    public static func encodeEither<A : ToJSON where A.T == A>(value : A) -> Either<JSONError, JSONValue> {
        return JSONEncoder.encodeEither(value)
    }
    
    public static func encodeEither<A : ToJSON where A.T == A>(value : [A]) -> Either<JSONError, JSONValue> {
        return JSONEncoder.encodeEither(value)
    }
    
    public static func encodeEither<A : ToJSON where A.T == A>(value : [Swift.String : A]) -> Either<JSONError, JSONValue> {
        return JSONEncoder.encodeEither(value)
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : A) -> JSONValue? {
        return JSONEncoder.encode(value)
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : [A]) -> JSONValue? {
        return JSONEncoder.encode(value)
    }
    
    public static func encode<A : ToJSON where A.T == A>(value : [Swift.String : A]) -> JSONValue? {
        return JSONEncoder.encode(value)
    }
}
