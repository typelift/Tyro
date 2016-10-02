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
    associatedtype T = Self
    static func fromJSON(_ value : JSONValue) -> Either<JSONError, T>
}

public protocol ToJSON {
    associatedtype T = Self
    static func toJSON(_ value : T) -> Either<JSONError, JSONValue>
}
