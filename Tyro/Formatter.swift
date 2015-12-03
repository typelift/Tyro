//
//  Formatter.swift
//  Tyro
//
//  Created by Matthew Purland on 11/18/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONValueConvertible : JSONDecoderType {
    var jsonValue : JSONValue? { get }
}

public protocol JSONFormatterType : JSONDecoderType, JSONEncoderType, JSONValueConvertible {
    typealias T
    typealias EncodedType = T
    typealias DecodedType = T
}

extension JSONValueConvertible {
    public func value() -> DecodedType? {
        return (decode <^> jsonValue) ?? nil
    }
    
    public func value() -> [DecodedType]? {
        return jsonValue?.array?.flatMap(self.decode) ?? nil
    }
    
    public func value() -> [String : DecodedType]? {
        return jsonValue?.object?.mapMaybe(self.decode) ?? nil
    }
}

extension JSONValue : JSONFormatterType {
    public typealias T = JSONValue
}
