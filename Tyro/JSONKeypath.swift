//
//  JSONKeypath.swift
//  Tyro
//
//  Created by Matthew Purland on 11/16/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// Represents a subscript into a nested set of dictionaries.  When used in conjunction with the
/// JSON decoding machinery, this class can be used to combine strings into keypaths to target
/// values inside nested JSON objects.
public struct JSONKeypath : StringLiteralConvertible {
    public typealias StringLiteralType = String
    
    public let path : [String]
    
    public init(_ path : [String]) {
        self.path = path
    }
    
    public init(unicodeScalarLiteral value : UnicodeScalar) {
        self.path = ["\(value)"]
    }
    
    public init(extendedGraphemeClusterLiteral value : String) {
        self.path = [value]
    }
    
    public init(stringLiteral value : String) {
        self.path = [value]
    }
}

extension JSONKeypath : Monoid {
    public static var mempty : JSONKeypath {
        return JSONKeypath([])
    }
    
    public func op(other : JSONKeypath) -> JSONKeypath {
        return JSONKeypath(self.path + other.path)
    }
}

extension JSONKeypath : CustomStringConvertible {
    public var description : String {
        return self.path.intersperse(".").reduce("", combine: +)
    }
}

internal func resolveKeypath(lhs : Dictionary<String, JSONValue>, rhs : JSONKeypath) -> JSONValue? {
    if rhs.path.isEmpty {
        return nil
    }
    
    switch rhs.path.match {
    case .Nil:
        return nil
    case let .Cons(hd, tl):
        if let o = lhs[hd] {
            switch o {
            case let .JSONObject(d) where rhs.path.count > 1:
                return resolveKeypath(d, rhs: JSONKeypath(tl))
            default:
                return o
            }
        }
        return nil
    }
}