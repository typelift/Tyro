//
//  JSONValue.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public enum JSONValue {
    case Array([JSONValue])
    case Object([Swift.String : JSONValue])
    case String(Swift.String)
    case Number(NSNumber)
    case Null
}

extension JSONValue : CustomStringConvertible {
    public var description : Swift.String {
        switch self {
        case .Array(let values):
            return "JSONValue(Array(\(values)))"
        case .Object(let value):
            return "JSONValue(Object(\(value)))"
        case .String(let value):
            return "JSONValue(String(\(value)))"
        case .Number(let value):
            return "JSONValue(Number(\(value)))"
        case .Null:
            return "JSONValue(Null)"
        }
    }
}

extension JSONValue : Equatable {}

public func == (lhs : JSONValue, rhs : JSONValue) -> Bool {
    switch (lhs, rhs) {
    case (.Array(let lhsValues), .Array(let rhsValues)):
        return lhsValues == rhsValues
    case (.Object(let lhsValue), .Object(let rhsValue)):
        return lhsValue == rhsValue
    case (.String(let lhsValue), .String(let rhsValue)):
        return lhsValue == rhsValue
    case (.Number(let lhsValue), .Number(let rhsValue)):
        return lhsValue.isEqual(to: rhsValue)
    case (.Null, .Null):
        return true
    default:
        return false
    }
}

public func == (lhs : JSONValue?, rhs : JSONValue?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    }
    
    return false
}

public protocol JSONValueable {
    var array : [JSONValue]? { get }
    var object : [Swift.String : JSONValue]? { get }
    var string : Swift.String? { get }
    var number : NSNumber? { get }
    var null : NSNull? { get }
    var anyObject : AnyObject? { get }
}

extension JSONValue : JSONValueable {
    public var array : [JSONValue]? {
        switch self {
        case .Array(let values): return values
        default: return nil
        }
    }
    
    public var object : [Swift.String : JSONValue]? {
        switch self {
        case .Object(let value): return value
        default: return nil
        }
    }
    
    public var string : Swift.String? {
        switch self {
        case .String(let value): return value
        case .Number(let value): return value.stringValue
        default: return nil
        }
    }
    
    public var number : NSNumber? {
        switch self {
        case .Number(let value): return value
        default: return nil
        }
    }
    
    public var null : NSNull? {
        switch self {
        case .Null: return NSNull()
        default: return nil
        }
    }
    
    public var anyObject : AnyObject? {
        switch self {
        case .Array(let values): return values.mapMaybe { $0.anyObject } as AnyObject?
        case .Object(let value): return value.mapMaybe { $0.anyObject } as AnyObject?
        case .String(let s): return s as AnyObject?
        case .Number(let n): return n
        case .Null: return NSNull()
        }
    }
}

extension JSONValue {
    /// Values for FromJSON
    public func value<A : FromJSON>() -> A? where A.T == A {
        return valueEither().right
    }

    public func valueEither<A : FromJSON>() -> Either<JSONError, A> where A.T == A {
        return A.fromJSON(self)
    }
    
    public func value<A : FromJSON>() -> [A]? where A.T == A {
        return valueEither().right
    }
    
    public func valueEither<A : FromJSON>() -> Either<JSONError, [A]> where A.T == A {
        return FromJSONArray<A, A>.fromJSON(self)
    }
    
    public func value<A : FromJSON>() -> [Swift.String : A]? where A.T == A {
        return valueEither().right
    }

    public func valueEither<A : FromJSON>() -> Either<JSONError, [Swift.String : A]> where A.T == A {
        return FromJSONDictionary<A, A>.fromJSON(self)
    }
    
    public func error<A : FromJSON>(_ type : A.Type) -> JSONError? {
        return type.fromJSON(self).left
    }
}

extension JSONValue {
    public subscript(keypath : JSONKeypath) -> JSONValue? {
        switch self {
        case .Object(let d):
            return keypath.resolve(d)
        default:
            return nil
        }
    }
}

extension JSONValue {
    public static func decodeEither(_ data : Data) -> Either<JSONError, JSONValue> {
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options : JSONSerialization.ReadingOptions(rawValue : 0))
            return JSONEncoder.encoder.encodeEither(object as AnyObject)
        }
        catch let error {
            return .Left(.Error(error, "Error while decoding data with decodeEither"))
        }
    }
    
    public static func decodeEither(_ json : Swift.String) -> Either<JSONError, JSONValue> {
        
        let t = (decodeEither <^> json.data(using: Swift.String.Encoding.utf8, allowLossyConversion : false))
        
        return  t ?? .Left(.Custom("JSON string (\(json)) could not be converted to Data using UTF-8 string encoding."))
    }
    
    public static func decode(_ data : Data) -> JSONValue? {
        return decodeEither(data).right
    }
    
    public static func encodeEither(_ value : JSONValue) -> Either<JSONError, Data> {
        return JSONDecoder.decoder.decodeEither(value).flatMap { (object) -> Either<JSONError, Data> in
            do {
                let data : Data = try JSONSerialization.data(withJSONObject: object, options : JSONSerialization.WritingOptions(rawValue : 0))
                return .Right(data)
            }
            catch let error {
                return .Left(.Error(error, "Error while decoding data with encodeEither"))
            }
        }
    }
    
    public static func toJSONData(_ value : JSONValue) -> Data? {
        return encodeEither(value).right
    }
    
    public static func toJSONString(_ value : JSONValue) -> Swift.String? {
        return toJSONData(value)?.toUTF8String()
    }
    
    public func toJSONData() -> Data? {
        return JSONValue.toJSONData(self)
    }
    
    public func toJSONString() -> Swift.String? {
        return JSONValue.toJSONString(self)
    }
}
