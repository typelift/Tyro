//
//  URL.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol URLJSONConvertibleType: FromJSON, ToJSON {
}

extension URLJSONConvertibleType {
    public typealias T = NSURL
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSURL> {
        switch value {
        case .String(let value):
            return NSURL(string: value).toEither(.Custom("Could not convert value (\(value)) to NSURL"))
        default:
            return .Left(.TypeMismatch("URL JSON", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(url: NSURL) -> Either<JSONError, JSONValue> {
        return .Right(.String(url.absoluteString))
    }
}

struct URLJSONFormatter: URLJSONConvertibleType {
    private init() {}
}
