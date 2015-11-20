//
//  Operators.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//postfix operator <?! {}
//
///// JSONFormatterType value operators
//public postfix func <?! <B: JSONFormatterType> (t: B?) -> B.F.T? {
//    return t?.value()
//}
//
//public postfix func <?! <B: JSONFormatterType> (t: B?) -> [B.F.T]? {
//    return t?.value()
//}
//
//public postfix func <?! <B: JSONFormatterType> (t: B?) -> [String: B.F.T]? {
//    return t?.value()
//}

/// JSONFormatterType decoding operators
public func <? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> B.F.T? {
    return (B.F.fromJSON <^> lhs?.jsonValue?[rhs])?.right
}

public func <? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [B.F.T]? {
    return lhs?.jsonValue?[rhs]?.array?.flatMap { B.F.fromJSON($0).right }
}

public func <? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [String: B.F.T]? {
    return lhs?.jsonValue?[rhs]?.object?.flatMap { B.F.fromJSON($0).right }
}

public func <?? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> B.F.T?? {
    return lhs <? rhs
}

public func <?? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [B.F.T]?? {
    return lhs <? rhs
}

public func <?? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [String: B.F.T]?? {
    return lhs <? rhs
}

/// JSONValue decoding operators

public func <? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> A? {
    return lhs?[rhs]?.value()
}

public func <? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [A]? {
    return lhs?[rhs]?.value()
}

public func <? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [String: A]? {
    return lhs?[rhs]?.value()
}

public func <?? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> A?? {
    return lhs <? rhs
}

public func <?? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [A]?? {
    return lhs <? rhs
}

public func <?? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [String: A]?? {
    return lhs <? rhs
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) throws -> A {
    if let result: A = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue: \(lhs)")
    }
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) throws -> [A] {
    if let result: [A] = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue: \(lhs)")
    }
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) throws -> [String: A] {
    if let result: [String: A] = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue: \(lhs)")
    }
}