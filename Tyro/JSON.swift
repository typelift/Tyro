//
//  JSON.swift
//  Tyro
//
//  Created by Matthew Purland on 11/16/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//public protocol JSONConvertible {
//    
//}
//
//public protocol JSON: JSONDecodable, JSONEncodable {}

///

public protocol JSONErrorType: ErrorType {
}

public enum JSONError: JSONErrorType {
    case Array([JSONError]) // errors
    case TypeMismatch(String, String) // expected / actual
    case Error(ErrorType, String) // error / message
    case Custom(String) // message
}

extension JSONError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Array(let errors):
            return "JSONError(Array(\"\(errors)\"))"
        case .TypeMismatch(let expected, let actual):
            return "JSONError(TypeMismatch(\"\(expected) is not \(actual)\"))"
        case .Error(let error, let message):
            return "JSONError(Error(\"\(message) error: \(error)\"))"
        case .Custom(let message):
            return "JSONError(Custom(\"\(message)\"))"
        }
    }
}

public enum JSONValue {
    case Array([JSONValue])
    case Object([Swift.String: JSONValue])
    case String(Swift.String)
    case Number(NSNumber)
    case Null
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

func == (lhs: JSONValue?, rhs: JSONValue?) -> Bool {
    if let lhs = lhs, rhs = rhs {
        return lhs == rhs
    }
    
    return false
//    switch (lhs, rhs) {
//    case (.Some(.Array(let lhsValues)), .Some(.Array(let rhsValues))):
//        return false
//    default:
//        return true
//    }
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
    func value<A: FromJSON>() -> A? {
        return A.fromJSON(self).right
    }
    
    func error<A: FromJSON>(type: A.Type) -> JSONError? {
        return type.fromJSON(self).left
    }
}

extension JSONValue {
    subscript(keypath: Swift.String) -> JSONValue? {
        switch self {
        case .Object(let d):
            return JSONKeypath(stringLiteral: keypath).resolve(d)
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

public protocol JSONDecoder {
    static func decode(value: AnyObject) -> Either<JSONError, JSONValue>
}

public protocol JSONEncoder {
    static func encode(value: JSONValue) -> Either<JSONError, AnyObject>
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

extension JSONEncoder {
    public static func encode(value: JSONValue) -> Either<JSONError, AnyObject> {
        return .Left(.Custom(""))
    }
}

extension JSONValue: JSONDecoder {}
extension JSONValue: JSONEncoder {}

public protocol FromJSON {
    static func fromJSON(value: JSONValue) -> Either<JSONError, Self>
}

public protocol ToJSON {
    static func toJSON(value: Self) -> Either<JSONError, JSONValue>
}

public protocol JSONConvertible: FromJSON, ToJSON {}

// MARK: - Types

extension Bool: JSONConvertible {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Bool> {
        switch value {
        case .Number(0), .Number(false):
            return .Right(false)
        case .Number(1), .Number(true):
            return .Right(true)
        default:
            return .Left(.TypeMismatch("\(Bool.self)", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(value: Bool) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

extension Int: JSONConvertible {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int> {
        switch value {
        case .Number(let value):
            return .Right(value.integerValue)
        default:
            return .Left(.TypeMismatch("\(Int.self)", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(value: Int) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}