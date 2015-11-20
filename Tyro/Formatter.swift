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
    typealias T
    var jsonValue: JSONValue? { get }
}

public protocol JSONFormatterType: JSONValueConvertible {
    typealias F: FromJSON
    
    func withFormatter(type: F.Type) -> JSONFormatter<F>
}

public class JSONFormatter<F: FromJSON>: JSONValueConvertible, JSONFormatterType {
    public typealias T = F.T
    
    private let internalJsonValue: JSONValue?
    private let internalValue: F.T?
    
    public var jsonValue: JSONValue? {
        if let internalValue = internalValue {
            return (JSONValue.encode <^> (internalValue as? AnyObject))?.right
        }
        else {
            return internalJsonValue
        }
    }
    
    public init(jsonValue: JSONValue?) {
        internalJsonValue = jsonValue
        internalValue = nil
    }
    
    public init(value: F.T?) {
        internalJsonValue = nil
        internalValue = value
    }
    
    public func withFormatter(type: F.Type) -> JSONFormatter<F> {
        let formatted = F.fromJSON <^> jsonValue
        return JSONFormatter(value: formatted?.right)
    }
}

extension JSONValue {    
    public func format<A: FromJSON>(type: A.Type) -> JSONFormatter<A> {
        return JSONFormatter<A>(jsonValue: self)
    }
}