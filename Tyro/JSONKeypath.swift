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
public struct JSONKeypath: StringLiteralConvertible {
    public typealias StringLiteralType = String
    
    public let path: [String]
    
    public init(_ path: [String]) {
        self.path = path
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalar) {
        self.path = ["\(value)"]
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.path = [value]
    }
    
    public init(stringLiteral value: String) {
        self.path = [value]
    }
}

extension JSONKeypath: Monoid {
    public static var mempty: JSONKeypath {
        return JSONKeypath([])
    }
    
    public func op(other: JSONKeypath) -> JSONKeypath {
        return JSONKeypath(self.path + other.path)
    }
}

extension JSONKeypath: CustomStringConvertible {
    public var description: String {
        return self.path.intersperse(".").reduce("", combine: +)
    }
}

extension JSONKeypath {
    func resolve(dictionary: Dictionary<String, JSONValue>) -> JSONValue? {
        if path.isEmpty {
            return nil
        }
        
        switch path.match {
        case .Nil:
            return nil
        case .Cons(let hd, let tl):
            if let o = dictionary[hd] {
                switch o {
                case .Object(let d) where path.count > 1:
                    return JSONKeypath(tl).resolve(d)
                default:
                    return o
                }
            }
            return nil
        }
    }
}