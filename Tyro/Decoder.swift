//
//  Decoder.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol JSONDecodable {
    typealias J = Self
    static func fromJSON(x: JSONValue) -> J?
}

public protocol JSONEncodable {
    typealias J
    static func toJSON(x: J) -> JSONValue
}

public protocol JSON: JSONDecodable, JSONEncodable { }