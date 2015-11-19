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
extension FromJSON where Self: RawRepresentable, Self.RawValue == Int {
    public static func fromJSON(value: JSONValue) -> Self? {
        switch value {
        case .Number(let n as Int):
            return self.init(rawValue: n)
        default:
            return nil
        }
    }
}

/// ToJSON conformance for Int enums
extension ToJSON where Self: RawRepresentable, Self.RawValue == Int {
    public static func toJSON(xs: Self) -> JSONValue {
        return .Number(xs.rawValue)
    }
}

/// FromJSON conformance for String enums
extension FromJSON where Self: RawRepresentable, Self.RawValue == String {
    public static func fromJSON(x: JSONValue) -> Self? {
        switch x {
        case .String(let s):
            return self.init(rawValue: s)
        default:
            return nil
        }
    }
}

/// ToJSON conformance for String enums
extension ToJSON where Self: RawRepresentable, Self.RawValue == String {
    public static func toJSON(xs: Self) -> JSONValue {
        return .String(xs.rawValue)
    }
}