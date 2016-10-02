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
    func encodeEither(_ value : EncodedType) -> Either<JSONError, JSONValue>
    func encode(_ value : EncodedType) -> JSONValue?
    
    func encodeEither(_ value : [EncodedType]) -> Either<JSONError, JSONValue>
    func encode(_ value : [EncodedType]) -> JSONValue?

    func encodeEither(_ value : [String : EncodedType]) -> Either<JSONError, JSONValue>
    func encode(_ value : [String : EncodedType]) -> JSONValue?
}

extension JSONEncoderType {
    
    public func encodeEither(_ value : [EncodedType]) -> Either<JSONError, JSONValue> {
        
        return value.flatMap(self.encodeEither).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }

    public func encodeEither(_ value : [String : EncodedType]) -> Either<JSONError, JSONValue> {

        return value.mapMaybe(self.encodeEither).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }

    public func encode(_ value : EncodedType) -> JSONValue? {
        return encodeEither(value).right
    }
    
    public func encode(_ value : [EncodedType]) -> JSONValue? {
        
        return encodeEither(value).right
    }
    
    public func encode(_ value : [String : EncodedType]) -> JSONValue? {
        
        return encodeEither(value).right
    }
}

public class JSONEncoder : JSONEncoderType {
    public static let encoder = JSONEncoder()
    private init() {}
    
    public func encodeEither(_ value : AnyObject) -> Either<JSONError, JSONValue> {
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
    
    public func encode(_ value : AnyObject) -> JSONValue? {
        
        return encodeEither(value).right
    }
}

/// Extra decoders for native types that are not of type AnyObject
extension JSONEncoderType {
    public static func encodeEither<A : ToJSON>(_ value : A) -> Either<JSONError, JSONValue> where A.T == A {

        return A.toJSON(value)
    }
    
    public static func encodeEither<A : ToJSON>(_ value : [A]) -> Either<JSONError, JSONValue> where A.T == A {
        
        return value.flatMap(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }
    
    public static func encodeEither<A : ToJSON>(_ value : [Swift.String : A]) -> Either<JSONError, JSONValue> where A.T == A {
        
        return value.mapMaybe(A.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }
    
    public static func encode<A : ToJSON>(_ value : A) -> JSONValue? where A.T == A {
        
        return encodeEither(value).right
    }
    
    public static func encode<A : ToJSON>(_ value : [A]) -> JSONValue? where A.T == A {
        
        let eitherJsonValue = encodeEither(value)
        return eitherJsonValue.right
    }
    
    public static func encode<A : ToJSON>(_ value : [Swift.String : A]) -> JSONValue? where A.T == A {
        
        let eitherJsonValue = encodeEither(value)
        return eitherJsonValue.right
    }
}

extension JSONValue : JSONEncoderType {
    public typealias EncodedType = AnyObject
    
    public func encodeEither(_ value : EncodedType) -> Either<JSONError, JSONValue> {
        
        return JSONEncoder.encoder.encodeEither(value)
    }
    
    public func encode(_ value : AnyObject) -> JSONValue? {
        
        return JSONEncoder.encoder.encode(value)
    }

    public static func encodeEither<A : ToJSON>(_ value : A) -> Either<JSONError, JSONValue> where A.T == A {
        
        return A.toJSON(value)
    }
    
    public static func encodeEither<A : ToJSON>(_ value : [A]) -> Either<JSONError, JSONValue> where A.T == A {

        return JSONEncoder.encodeEither(value)
    }
    
    public static func encodeEither<A : ToJSON>(value : [Swift.String : A]) -> Either<JSONError, JSONValue> where A.T == A {

        return JSONEncoder.encodeEither(value)
    }
    
    public static func encode<A : ToJSON>(value : A) -> JSONValue? where A.T == A {

        return JSONEncoder.encode(value)
    }
    
    public static func encode<A : ToJSON>(value : [A]) -> JSONValue? where A.T == A {

        return JSONEncoder.encode(value)
    }
    
    public static func encode<A : ToJSON>(value : [Swift.String : A]) -> JSONValue? where A.T == A {

        return JSONEncoder.encode(value)
    }
}
