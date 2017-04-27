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
    public typealias T = URL
    
    fileprivate init() {}
    
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, URL> {
        switch value {
        case .String(let value):
            return URL(string : value).toEither(.Custom("Could not convert value (\(value)) to URL"))
        default:
            return .Left(.TypeMismatch("URL JSON", "\(type(of: value).self)"))
        }
    }
    
    public static func toJSON(_ url : URL) -> Either<JSONError, JSONValue> {
        return .Right(.String(url.absoluteString))
    }
}

public struct URLJSONFormatter : JSONFormatterType {

    public typealias T = URLJSONConverter.T
    
    public fileprivate(set) var jsonValue : JSONValue?
    
    public init(_ jsonValue : JSONValue?) {
        self.jsonValue = jsonValue
    }
    
    public func decodeEither(_ value : JSONValue) -> Either<JSONError, T> {
        return URLJSONConverter.fromJSON(value)
    }
    
    public func encodeEither(_ value : T) -> Either<JSONError, JSONValue> {
        return URLJSONConverter.toJSON(value)
    }
}
