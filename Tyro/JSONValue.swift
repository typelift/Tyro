//
//  JSONValue.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//public typealias JSONValueLazyArray = () -> [JSONValue]

public enum JSONValue {
    case Array([JSONValue])
    case Object([Swift.String: JSONValue])
    case String(Swift.String)
    case Number(NSNumber)
//    case LazyArray(() -> [JSONValue])
    case Null
}

extension JSONValue: CustomStringConvertible {
    public var description: Swift.String {
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

extension JSONValue: Equatable {}

public func == (lhs: JSONValue, rhs: JSONValue) -> Bool {
    switch (lhs, rhs) {
    case (.Array(let lhsValues), .Array(let rhsValues)):
        return lhsValues == rhsValues
    case (.Object(let lhsValue), .Object(let rhsValue)):
        return lhsValue == rhsValue
    case (.String(let lhsValue), .String(let rhsValue)):
        return lhsValue == rhsValue
    case (.Number(let lhsValue), .Number(let rhsValue)):
        return lhsValue == rhsValue
    case (.Null, .Null):
        return true
    default:
        return false
    }
}

public func == (lhs: JSONValue?, rhs: JSONValue?) -> Bool {
    if let lhs = lhs, rhs = rhs {
        return lhs == rhs
    }
    
    return false
}

protocol JSONValueable {
    var array: [JSONValue]? { get }
    var object: [Swift.String: JSONValue]? { get }
    var string: Swift.String? { get }
    var number: NSNumber? { get }
    var null: NSNull? { get }
    var anyObject: AnyObject? { get }
}

extension JSONValue: JSONValueable {
    var array: [JSONValue]? {
        switch self {
        case .Array(let values): return values
        default: return nil
        }
    }
    
    var object: [Swift.String: JSONValue]? {
        switch self {
        case .Object(let value): return value
        default: return nil
        }
    }
    
    var string: Swift.String? {
        switch self {
        case .String(let value): return value
        default: return nil
        }
    }
    
    var number: NSNumber? {
        switch self {
        case .Number(let value): return value
        default: return nil
        }
    }
    
    var null: NSNull? {
        switch self {
        case .Null: return NSNull()
        default: return nil
        }
    }
    
    var anyObject: AnyObject? {
        switch self {
        case .Array(let values): return values as? AnyObject
        case .Object(let value): return value as? AnyObject
        case .String(let s): return s
        case .Number(let n): return n
        case .Null: return NSNull()
        }
    }
}

extension JSONValue {
    /// Values for FromJSON
    func value<A: FromJSON where A.T == A>() -> A? {
        return valueEither().right
    }

    func valueEither<A: FromJSON where A.T == A>() -> Either<JSONError, A> {
        return A.fromJSON(self)
    }
    
    func value<A: FromJSON where A.T == A>() -> [A]? {
        return valueEither().right
    }
    
    func valueEither<A: FromJSON where A.T == A>() -> Either<JSONError, [A]> {
        return FromJSONArray<A, A>.fromJSON(self)
    }
    
    func value<A: FromJSON where A.T == A>() -> [Swift.String: A]? {
        return valueEither().right
    }

    func valueEither<A: FromJSON where A.T == A>() -> Either<JSONError, [Swift.String: A]> {
        return FromJSONDictionary<A, A>.fromJSON(self)
    }
    
    func error<A: FromJSON>(type: A.Type) -> JSONError? {
        return type.fromJSON(self).left
    }
}

extension JSONValue {
    subscript(keypath: JSONKeypath) -> JSONValue? {
        switch self {
        case .Object(let d):
            return keypath.resolve(d)
        default:
            return nil
        }
    }
}

extension JSONValue {
    public static func decodeEither(data: NSData) -> Either<JSONError, JSONValue> {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
            return JSONEncoder.encoder.encodeEither(object)
        }
        catch let error {
            return .Left(.Error(error, "Error while decoding data with decodeEither"))
        }
    }
    
    public static func decodeEither(json: Swift.String) -> Either<JSONError, JSONValue> {
        return (decodeEither <^> json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)) ?? .Left(.Custom("JSON string (\(json)) could not be converted to NSData using UTF-8 string encoding."))
    }
    
    public static func decode(data: NSData) -> JSONValue? {
        return decodeEither(data).right
    }
    
    public static func encodeEither(value: JSONValue) -> Either<JSONError, NSData> {
        return JSONDecoder.decoder.decodeEither(value).flatMap { (object) -> Either<JSONError, NSData> in
            do {
                let data: NSData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions(rawValue: 0))
                return .Right(data)
            }
            catch let error {
                return .Left(.Error(error, "Error while decoding data with encodeEither"))
            }
        }
    }
    
    public static func toJSONData(value: JSONValue) -> NSData? {
        return encodeEither(value).right
    }
    
    public static func toJSONString(value: JSONValue) -> Swift.String? {
        return toJSONData(value)?.toUTF8String()
    }
    
    public func toJSONData() -> NSData? {
        return JSONValue.toJSONData(self)
    }
    
    public func toJSONString() -> Swift.String? {
        return JSONValue.toJSONString(self)
    }
}
