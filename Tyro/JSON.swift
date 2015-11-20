//
//  JSON.swift
//  Tyro
//
//  Created by Matthew Purland on 11/16/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol FromJSON {
    typealias T = Self
    static func fromJSON<F: FromJSONFormatter where F.T == T>(formatter: F?, _ value: JSONValue) -> Either<JSONError, T>
}

public protocol ToJSON {
    typealias T = Self
    static func toJSON<F: ToJSONFormatter where F.T == T>(formatter: F?, _ value: T) -> Either<JSONError, JSONValue>
}

//extension FromJSON {
//    public static func fromJSON(value: JSONValue) -> Either<JSONError, T> {
//        return fromJSON(nil, value)
//    }
//}
//
//extension ToJSON {
//    public static func toJSON(value: T) -> Either<JSONError, JSONValue> {
//        return toJSON(nil, value)
//    }
//}

public protocol FromJSONFormatter {
//    typealias FormattedType = Self
//    func fromJSON(value: JSONValue) -> Either<JSONError, FormattedType>
    typealias T
    
    static var sharedFormatter: Self { get }
    
    func fromJSON(value: JSONValue) -> Either<JSONError, T>
}

public protocol ToJSONFormatter {
    typealias T
//    typealias FormattedType = Self
//    func toJSON(value: FormattedType) -> Either<JSONError, JSONValue>

    static var sharedFormatter: Self { get }
    
    func toJSON(value: T) -> Either<JSONError, JSONValue>
}