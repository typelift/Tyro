//
//  URL.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct URLJSONConverter : FromJSON, ToJSON {
    public typealias T = NSURL
    
    private init() {}
    
    public static func fromJSON(value : JSONValue) -> Either<JSONError, NSURL> {
        switch value {
        case .String(let value):
            return NSURL(string : value).toEither(.Custom("Could not convert value (\(value)) to NSURL"))
        default:
            return .Left(.TypeMismatch("URL JSON", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(url : NSURL) -> Either<JSONError, JSONValue> {
        return .Right(.String(url.absoluteString))
    }
}

public struct URLJSONFormatter : JSONFormatterType {
    public typealias T = URLJSONConverter.T
    
    public private(set) var jsonValue : JSONValue?
    
    init(_ jsonValue : JSONValue?) {
        self.jsonValue = jsonValue
    }
    
    public func decodeEither(value : JSONValue) -> Either<JSONError, T> {
        return URLJSONConverter.fromJSON(value)
    }
    
    public func encodeEither(value : T) -> Either<JSONError, JSONValue> {
        return URLJSONConverter.toJSON(value)
    }
}
