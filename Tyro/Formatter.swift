//
//  Formatter.swift
//  Tyro
//
//  Created by Matthew Purland on 11/18/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONValueConvertible {
    var jsonValue: JSONValue? { get }
}

public protocol JSONFormatterType: JSONValueConvertible {
    typealias F: FromJSON
  
    func value() -> F.T?
    func value(keypath: JSONKeypath?) -> F.T?
    
    func value() -> [F.T]?
    func value(keypath: JSONKeypath?) -> [F.T]?
    
    func value() -> [String: F.T]?
    func value(keypath: JSONKeypath?) -> [String: F.T]?
}

public class JSONFormatter<A: FromJSON>: JSONValueConvertible, JSONFormatterType {
    public typealias F = A
    public typealias T = F.T
    
    private let internalJsonValue: JSONValue?
    
    public var jsonValue: JSONValue? {
        return internalJsonValue
    }
    
    public init(jsonValue: JSONValue?) {
        internalJsonValue = jsonValue
    }
    
    public func value() -> F.T? {
        return value(nil)
    }
    
    public func value(keypath: JSONKeypath?) -> F.T? {
        return (F.fromJSON <^> jsonValue?[keypath])?.right
    }
    
    public func value() -> [F.T]? {
        return value(nil)
    }
    
    public func value(keypath: JSONKeypath?) -> [F.T]? {
        return jsonValue?[keypath]?.array?.flatMap { F.fromJSON($0).right }
    }
    
    public func value() -> [String: F.T]? {
        return value(nil)
    }
    
    public func value(keypath: JSONKeypath?) -> [String: F.T]? {
        return jsonValue?[keypath]?.object?.flatMap { F.fromJSON($0).right }
    }
}

extension JSONValue {
    public func format<A: FromJSON>(type: A.Type) -> JSONFormatter<A> {
        return JSONFormatter<A>(jsonValue: self)
    }
    
    public func format<A: FromJSON, B: JSONFormatterType where B.F == A>(type: B) -> B {
        return type
    }
}