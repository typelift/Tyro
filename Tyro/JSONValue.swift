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
    case Object([Swift.String: JSONValue])
    case String(Swift.String)
    case Number(NSNumber)
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

extension JSONValue {
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
}

extension JSONValue {
    func value<A: FromJSON where A.T == A>() -> A? {
        return A.fromJSON(self).right
    }
    
    func value<A: FromJSON where A.T == A>() -> [A]? {
        return FromJSONArray<A, A>.fromJSON(self).right
    }
    
    func value<A: FromJSON where A.T == A>() -> [Swift.String: A]? {
        return FromJSONDictionary<A, A>.fromJSON(self).right
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
    public static func deserialize(data: NSData) -> Either<JSONError, JSONValue> {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
            return JSONValue.decode(object)
        }
        catch let error {
            return .Left(.Error(error, "Error while deserializing data"))
        }
    }
    
    public static func deserialize(json: Swift.String) -> Either<JSONError, JSONValue> {
        return (deserialize <^> json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)) ?? .Left(.Custom("JSON string (\(json)) could not be converted to NSData using UTF-8 string encoding."))
    }
    
    public static func serialize(value: JSONValue) -> Either<JSONError, NSData> {
        return JSONValue.encode(value).flatMap { (object) -> Either<JSONError, NSData> in
            do {
                let data: NSData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions(rawValue: 0))
                return .Right(data)
            }
            catch let error {
                return .Left(.Error(error, "Error while serializing data"))
            }
        }
    }
}
