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
    static func fromJSON<F: FromJSONFormatter where F.T == T>(formatter: F?)(value: JSONValue) -> Either<JSONError, T>
}

public protocol ToJSON {
    typealias T = Self
    static func toJSON<F: ToJSONFormatter where F.T == T>(formatter: F?, value: T) -> Either<JSONError, JSONValue>
}

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