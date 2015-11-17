//
//  Enum.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// Make Swift enum JSONDecodable that has a raw value of type Int
extension JSONDecodable where Self: RawRepresentable, Self.RawValue == Int {
    public static func fromJSON(x: JSONValue) -> Self? {
        switch x {
        case let .JSONNumber(n as Int):
            return self.init(rawValue: n)
        default:
            return nil
        }
    }
}

/// Make Swift enum JSONEncodable that has a raw value of type Int
extension JSONEncodable where Self: RawRepresentable, Self.RawValue == Int {
    public static func toJSON(xs: Self) -> JSONValue {
        return .JSONNumber(xs.rawValue)
    }
}

/// Make Swift enum JSONDecodable that has a raw value of type String
extension JSONDecodable where Self: RawRepresentable, Self.RawValue == String {
    public static func fromJSON(x: JSONValue) -> Self? {
        switch x {
        case let .JSONString(s):
            return self.init(rawValue: s)
        default:
            return nil
        }
    }
}

/// Make Swift enum JSONEncodable that has a raw value of type String
extension JSONEncodable where Self: RawRepresentable, Self.RawValue == String {
    public static func toJSON(xs: Self) -> JSONValue {
        return .JSONString(xs.rawValue)
    }
}