//
//  Types.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// String
extension String : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, String> {
        switch value {
        case .String(let value):
            return .Right(value)
        case .Number(let value):
            return .Right(value.stringValue)
        default:
            return .Left(.TypeMismatch("\(String.self)", "\(type(of: value).self)"))
        }
    }
}

extension String : ToJSON {
    public static func toJSON(_ value : String) -> Either<JSONError, JSONValue> {
        return .Right(.String(value))
    }
}

/// Bool
extension Bool : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Bool> {
        switch value {
        case .Number(0), .Number(false):
            return .Right(false)
        case .Number(1), .Number(true):
            return .Right(true)
        default:
            return .Left(.TypeMismatch("\(Bool.self)", "\(type(of: value).self)"))
        }
    }
}

extension Bool : ToJSON {
    public static func toJSON(_ value : Bool) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value: value)))
    }
}

/// Int
extension Int : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Int> {
        return value.number.map { $0.intValue }.toEither(.TypeMismatch("\(Int.self)", "\(type(of: value).self)"))
    }
}

extension Int : ToJSON {
    public static func toJSON(_ value : Int) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value: value)))
    }
}

/// Int8
extension Int8 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Int8> {
        return value.number.map { $0.int8Value }.toEither(.TypeMismatch("\(Int8.self)", "\(type(of: value).self)"))
    }
}

extension Int8 : ToJSON {
    public static func toJSON(_ value : Int8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// Int16
extension Int16 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Int16> {
        return value.number.map { $0.int16Value }.toEither(.TypeMismatch("\(Int16.self)", "\(type(of: value).self)"))
    }
}

extension Int16 : ToJSON {
    public static func toJSON(_ value : Int16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// Int32
extension Int32 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Int32> {
        return value.number.map{ $0.int32Value }.toEither(.TypeMismatch("\(Int32.self)", "\(type(of: value).self)"))
    }
}

extension Int32 : ToJSON {
    public static func toJSON(_ value : Int32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// Int64
extension Int64 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Int64> {
        return value.number.map { $0.int64Value }.toEither(.TypeMismatch("\(Int64.self)", "\(type(of: value).self)"))
    }
}

extension Int64 : ToJSON {
    public static func toJSON(_ value : Int64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// UInt
extension UInt : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, UInt> {
        return value.number.map { $0.uintValue }.toEither(.TypeMismatch("\(UInt.self)", "\(type(of: value).self)"))
    }
}

extension UInt : ToJSON {
    public static func toJSON(_ value : UInt) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// UInt8
extension UInt8 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, UInt8> {
        return value.number.map { $0.uint8Value }.toEither(.TypeMismatch("\(UInt8.self)", "\(type(of: value).self)"))
    }
}

extension UInt8 : ToJSON {
    public static func toJSON(_ value : UInt8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// UInt16
extension UInt16 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, UInt16> {
        return value.number.map { $0.uint16Value }.toEither(.TypeMismatch("\(UInt16.self)", "\(type(of: value).self)"))
    }
}

extension UInt16 : ToJSON {
    public static func toJSON(_ value : UInt16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// UInt32
extension UInt32 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, UInt32> {
        return value.number.map { $0.uint32Value }.toEither(.TypeMismatch("\(UInt32.self)", "\(type(of: value).self)"))
    }
}

extension UInt32 : ToJSON {
    public static func toJSON(_ value : UInt32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// UInt64
extension UInt64 : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, UInt64> {
        return value.number.map { $0.uint64Value }.toEither(.TypeMismatch("\(UInt64.self)", "\(type(of: value).self)"))
    }
}

extension UInt64 : ToJSON {
    public static func toJSON(_ value : UInt64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// Float
extension Float : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Float> {
        return value.number.map { $0.floatValue }.toEither(.TypeMismatch("\(Float.self)", "\(type(of: value).self)"))
    }
}

extension Float : ToJSON {
    public static func toJSON(_ value : Float) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}

/// Double
extension Double : FromJSON {
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, Double> {
        return value.number.map { $0.doubleValue }.toEither(.TypeMismatch("\(Double.self)", "\(type(of: value).self)"))
    }
}

extension Double : ToJSON {
    public static func toJSON(_ value : Double) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(value : value)))
    }
}
