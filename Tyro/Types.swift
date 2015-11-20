//
//  Types.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

internal func fromEitherValue<T, F: FromJSONFormatter where F.T == T>(formatter: F?, _ value: JSONValue) -> Either<JSONError, T> {
    return formatter?.fromJSON(value) ?? .Left(.Custom("No formatter"))
}

internal func toEitherValue<T, F: ToJSONFormatter where F.T == T>(formatter: F?, _ value: T) -> Either<JSONError, JSONValue> {
    return formatter?.toJSON(value) ?? .Left(.Custom("No formatter"))
}

public protocol FormatterFromToJSON: FromJSON, ToJSON {
    typealias FromFormatterType: FromJSONFormatter
    typealias ToFormatterType: ToJSONFormatter
    
    typealias Type = Self
    
    static func defaultFromFormatter<F: FromJSONFormatter where F.T == FromFormatterType.T>() -> F?
    static func defaultToFormatter<F: ToJSONFormatter where F.T == FromFormatterType.T>() -> F?
}

extension FormatterFromToJSON {
    public static func fromJSON<F: FromJSONFormatter where F.T == Type>(formatter: F?, value: JSONValue) -> Either<JSONError, Type> {
        return fromEitherValue(formatter, value)
    }
    
    public static func toJSON<F: ToJSONFormatter where F.T == Type>(formatter: F?, value: Type) -> Either<JSONError, JSONValue> {
        return toEitherValue(formatter, value)
    }
    
    public static func defaultFromFormatter<F: FromJSONFormatter where F.T == FromFormatterType.T>() -> F? {
        return FromFormatterType.sharedFormatter as? F
    }
    
    public static func defaultToFormatter<F: ToJSONFormatter where F.T == FromFormatterType.T>() -> F? {
        return ToFormatterType.sharedFormatter as? F
    }
}

/// String
public struct StringFormatter {
    public typealias T = String
    
    public static var sharedFormatter: StringFormatter {
        return self.init()
    }
}

extension StringFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, String> {
        switch value {
        case .String(let value):
            return .Right(value)
        default:
            return .Left(.TypeMismatch("\(String.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension StringFormatter: ToJSONFormatter {
    public func toJSON(value: String) -> Either<JSONError, JSONValue> {
        return .Right(.String(value))
    }
}

extension String: FormatterFromToJSON {
    public typealias FromFormatterType = StringFormatter
    public typealias ToFormatterType = StringFormatter
}

/// Bool
public struct BoolFormatter {
    public typealias T = Bool
    
    public static var sharedFormatter: BoolFormatter {
        return self.init()
    }
}

extension BoolFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Bool> {
        switch value {
        case .Number(0), .Number(false):
            return .Right(false)
        case .Number(1), .Number(true):
            return .Right(true)
        default:
            return .Left(.TypeMismatch("\(Bool.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension BoolFormatter: ToJSONFormatter {
    public func toJSON(value: Bool) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

extension Bool: FormatterFromToJSON {
    public typealias FromFormatterType = BoolFormatter
    public typealias ToFormatterType = BoolFormatter
}

/// Int
public struct IntFormatter {
    public typealias T = Int
    
    public static var sharedFormatter: IntFormatter {
        return self.init()
    }
}

extension IntFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Int> {
        return value.number.map { $0.integerValue }.toEither(.TypeMismatch("\(Int.self)", "\(value.dynamicType.self)"))
    }
}

extension IntFormatter: ToJSONFormatter {
    public func toJSON(value: Int) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

extension Int: FormatterFromToJSON {
    public typealias FromFormatterType = IntFormatter
    public typealias ToFormatterType = IntFormatter
}

/// Int8
public struct Int8Formatter {
    public typealias T = Int8
    
    public static var sharedFormatter: Int8Formatter {
        return self.init()
    }
}

extension Int8Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Int8> {
        return value.number.map { $0.charValue }.toEither(.TypeMismatch("\(Int8.self)", "\(value.dynamicType.self)"))
    }
}

extension Int8Formatter: ToJSONFormatter {
    public func toJSON(value: Int8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(char: value)))
    }
}

extension Int8: FormatterFromToJSON {
    public typealias FromFormatterType = Int8Formatter
    public typealias ToFormatterType = Int8Formatter
}

/// Int16
public struct Int16Formatter {
    public typealias T = Int16
    
    public static var sharedFormatter: Int16Formatter {
        return self.init()
    }
}

extension Int16Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Int16> {
        return value.number.map { $0.shortValue }.toEither(.TypeMismatch("\(Int16.self)", "\(value.dynamicType.self)"))
    }
}

extension Int16Formatter: ToJSONFormatter {
    public func toJSON(value: Int16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(short: value)))
    }
}

extension Int16: FormatterFromToJSON {
    public typealias FromFormatterType = Int16Formatter
    public typealias ToFormatterType = Int16Formatter
}

/// Int32
public struct Int32Formatter {
    public typealias T = Int32
    
    public static var sharedFormatter: Int32Formatter {
        return self.init()
    }
}

extension Int32Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Int32> {
        return value.number.map { $0.intValue }.toEither(.TypeMismatch("\(Int32.self)", "\(value.dynamicType.self)"))
    }
}

extension Int32Formatter: ToJSONFormatter {
    public func toJSON(value: Int32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(int: value)))
    }
}

extension Int32: FormatterFromToJSON {
    public typealias FromFormatterType = Int32Formatter
    public typealias ToFormatterType = Int32Formatter
}

/// Int64
public struct Int64Formatter {
    public typealias T = Int64
    
    public static var sharedFormatter: Int64Formatter {
        return self.init()
    }
}

extension Int64Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Int64> {
        return value.number.map { $0.longLongValue }.toEither(.TypeMismatch("\(Int64.self)", "\(value.dynamicType.self)"))
    }
}

extension Int64Formatter: ToJSONFormatter {
    public func toJSON(value: Int64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(longLong: value)))
    }
}

extension Int64: FormatterFromToJSON {
    public typealias FromFormatterType = Int64Formatter
    public typealias ToFormatterType = Int64Formatter
}

/// UInt
public struct UIntFormatter {
    public typealias T = UInt
    
    public static var sharedFormatter: UIntFormatter {
        return self.init()
    }
}

extension UIntFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, UInt> {
        return value.number.map { $0.unsignedIntegerValue }.toEither(.TypeMismatch("\(UInt.self)", "\(value.dynamicType.self)"))
    }
}

extension UIntFormatter: ToJSONFormatter {
    public func toJSON(value: UInt) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedInteger: value)))
    }
}

extension UInt: FormatterFromToJSON {
    public typealias FromFormatterType = UIntFormatter
    public typealias ToFormatterType = UIntFormatter
}

/// UInt8
public struct UInt8Formatter {
    public typealias T = UInt8
    
    public static var sharedFormatter: UInt8Formatter {
        return self.init()
    }
}

extension UInt8Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, UInt8> {
        return value.number.map { $0.unsignedCharValue }.toEither(.TypeMismatch("\(UInt8.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt8Formatter: ToJSONFormatter {
    public func toJSON(value: UInt8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedChar: value)))
    }
}

extension UInt8: FormatterFromToJSON {
    public typealias FromFormatterType = UInt8Formatter
    public typealias ToFormatterType = UInt8Formatter
}

/// UInt16
public struct UInt16Formatter {
    public typealias T = UInt16
    
    public static var sharedFormatter: UInt16Formatter {
        return self.init()
    }
}

extension UInt16Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, UInt16> {
        return value.number.map { $0.unsignedShortValue }.toEither(.TypeMismatch("\(UInt16.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt16Formatter: ToJSONFormatter {
    public func toJSON(value: UInt16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedShort: value)))
    }
}

extension UInt16: FormatterFromToJSON {
    public typealias FromFormatterType = UInt16Formatter
    public typealias ToFormatterType = UInt16Formatter
}

/// UInt32
public struct UInt32Formatter {
    public typealias T = UInt32
    
    public static var sharedFormatter: UInt32Formatter {
        return self.init()
    }
}

extension UInt32Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, UInt32> {
        return value.number.map { $0.unsignedIntValue }.toEither(.TypeMismatch("\(UInt32.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt32Formatter: ToJSONFormatter {
    public func toJSON(value: UInt32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedInt: value)))
    }
}

extension UInt32: FormatterFromToJSON {
    public typealias FromFormatterType = UInt32Formatter
    public typealias ToFormatterType = UInt32Formatter
}

/// UInt64
public struct UInt64Formatter {
    public typealias T = UInt64
    
    public static var sharedFormatter: UInt64Formatter = {
        return UInt64Formatter()
    }()
}

extension UInt64Formatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, UInt64> {
        return value.number.map { $0.unsignedLongLongValue }.toEither(.TypeMismatch("\(UInt64.self)", "\(value.dynamicType.self)"))
    }
}

extension UInt64Formatter: ToJSONFormatter {
    public func toJSON(value: UInt64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedLongLong: value)))
    }
}

extension UInt64: FormatterFromToJSON {
    public typealias FromFormatterType = UInt64Formatter
    public typealias ToFormatterType = UInt64Formatter
}

/// Float
public struct FloatFormatter {
    public typealias T = Float
    
    public static var sharedFormatter: FloatFormatter = {
        return FloatFormatter()
    }()
}

extension FloatFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Float> {
        return value.number.map { $0.floatValue }.toEither(.TypeMismatch("\(Float.self)", "\(value.dynamicType.self)"))
    }
}

extension FloatFormatter: ToJSONFormatter {
    public func toJSON(value: Float) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(float: value)))
    }
}

extension Float: FormatterFromToJSON {
    public typealias FromFormatterType = FloatFormatter
    public typealias ToFormatterType = FloatFormatter
}

/// Double
public struct DoubleFormatter {
    public typealias T = Double
    
    public static var sharedFormatter: DoubleFormatter = {
        return DoubleFormatter()
    }()
}

extension DoubleFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, Double> {
        return value.number.map { $0.doubleValue }.toEither(.TypeMismatch("\(Double.self)", "\(value.dynamicType.self)"))
    }
}

extension DoubleFormatter: ToJSONFormatter {
    public func toJSON(value: Double) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(double: value)))
    }
}

extension Double: FormatterFromToJSON {
    public typealias FromFormatterType = DoubleFormatter
    public typealias ToFormatterType = DoubleFormatter
}
