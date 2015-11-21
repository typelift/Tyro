//
//  Enum.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// FromJSON conformance for Int enums
extension FromJSON where Self : RawRepresentable, Self.RawValue == Int {    
    public static func fromJSON(value : JSONValue) -> Either<JSONError, T> {
        switch value {
        case .Number(let n as Int):
            let x : T? = self.init(rawValue : n) as? T
            return x.toEither(.Custom("Raw value could not be converted"))
        default:
            return .Left(.TypeMismatch("\(JSONValue.Number.self)","\(value.self)"))
        }
    }
}

/// ToJSON conformance for Int enums
extension ToJSON where Self : RawRepresentable, Self.RawValue == Int, T == Self {
    public static func toJSON(value : T) -> Either<JSONError, JSONValue> {
        return .Right(.Number(value.rawValue))
    }
}

/// FromJSON conformance for String enums
extension FromJSON where Self : RawRepresentable, Self.RawValue == String {
    public static func fromJSON(value : JSONValue) -> Either<JSONError, T> {
        switch value {
        case .String(let s):
            let x : T? = self.init(rawValue : s) as? T
            return x.toEither(.Custom("Raw value could not be converted"))
        default:
            return .Left(.TypeMismatch("\(JSONValue.Number.self)","\(value.self)"))
        }
    }
}

/// ToJSON conformance for String enums
extension ToJSON where Self : RawRepresentable, Self.RawValue == String, T == Self {
    public static func toJSON(value : T) -> Either<JSONError, JSONValue> {
        return .Right(.String(value.rawValue))
    }
}
