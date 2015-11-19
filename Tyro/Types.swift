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
extension String: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, String> {
        switch value {
        case .String(let value):
            return .Right(value)
        default:
            return .Left(.TypeMismatch("\(String.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension String: ToJSON {
    public static func toJSON(value: String) -> Either<JSONError, JSONValue> {
        return .Right(.String(value))
    }
}

/// Bool
extension Bool: FromJSON {
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
}

extension Bool: ToJSON {
    public static func toJSON(value: Bool) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

/// Int
extension Int: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int> {
        switch value {
        case .Number(let value):
            return .Right(value.integerValue)
        default:
            return .Left(.TypeMismatch("\(Int.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Int: ToJSON {
    public static func toJSON(value: Int) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value))
    }
}

/// Int8
extension Int8: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int8> {
        switch value {
        case .Number(let value):
            return .Right(value.charValue)
        default:
            return .Left(.TypeMismatch("\(Int8.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Int8: ToJSON {
    public static func toJSON(value: Int8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(char: value)))
    }
}

/// Int16
extension Int16: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int16> {
        switch value {
        case .Number(let value):
            return .Right(value.shortValue)
        default:
            return .Left(.TypeMismatch("\(Int16.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Int16: ToJSON {
    public static func toJSON(value: Int16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(short: value)))
    }
}

/// Int32
extension Int32: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int32> {
        switch value {
        case .Number(let value):
            return .Right(value.intValue)
        default:
            return .Left(.TypeMismatch("\(Int32.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Int32: ToJSON {
    public static func toJSON(value: Int32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(int: value)))
    }
}

/// Int64
extension Int64: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Int64> {
        switch value {
        case .Number(let value):
            return .Right(value.longLongValue)
        default:
            return .Left(.TypeMismatch("\(Int64.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Int64: ToJSON {
    public static func toJSON(value: Int64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(longLong: value)))
    }
}

/// UInt8
extension UInt8: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, UInt8> {
        switch value {
        case .Number(let value):
            return .Right(value.unsignedCharValue)
        default:
            return .Left(.TypeMismatch("\(UInt8.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension UInt8: ToJSON {
    public static func toJSON(value: UInt8) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedChar: value)))
    }
}

/// UInt16
extension UInt16: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, UInt16> {
        switch value {
        case .Number(let value):
            return .Right(value.unsignedShortValue)
        default:
            return .Left(.TypeMismatch("\(UInt16.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension UInt16: ToJSON {
    public static func toJSON(value: UInt16) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedShort: value)))
    }
}

/// UInt32
extension UInt32: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, UInt32> {
        switch value {
        case .Number(let value):
            return .Right(value.unsignedIntValue)
        default:
            return .Left(.TypeMismatch("\(UInt32.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension UInt32: ToJSON {
    public static func toJSON(value: UInt32) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedInt: value)))
    }
}

/// UInt64
extension UInt64: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, UInt64> {
        switch value {
        case .Number(let value):
            return .Right(value.unsignedLongLongValue)
        default:
            return .Left(.TypeMismatch("\(UInt64.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension UInt64: ToJSON {
    public static func toJSON(value: UInt64) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(unsignedLongLong: value)))
    }
}

/// Float
extension Float: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Float> {
        switch value {
        case .Number(let value):
            return .Right(value.floatValue)
        default:
            return .Left(.TypeMismatch("\(Float.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Float: ToJSON {
    public static func toJSON(value: Float) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(float: value)))
    }
}

/// Double
extension Double: FromJSON {
    public static func fromJSON(value: JSONValue) -> Either<JSONError, Double> {
        switch value {
        case .Number(let value):
            return .Right(value.doubleValue)
        default:
            return .Left(.TypeMismatch("\(Double.self)", "\(value.dynamicType.self)"))
        }
    }
}

extension Double: ToJSON {
    public static func toJSON(value: Double) -> Either<JSONError, JSONValue> {
        return .Right(.Number(NSNumber(double: value)))
    }
}
