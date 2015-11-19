//
//  Operators.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

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
    return lhs <? rhs ?? nil
}

public func <?? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [B.F.T]?? {
    return lhs <? rhs ?? nil
}

public func <?? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [String: B.F.T]?? {
    return lhs <? rhs ?? nil
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
    return lhs <? rhs ?? nil
}

public func <?? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [A]?? {
    return lhs <? rhs ?? nil
}

public func <?? <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [String: A]?? {
    return lhs <? rhs ?? nil
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> A {
    if let result: A = (lhs <? rhs) {
        return result
    }
    else {
        return error("Could not find value at keypath \(rhs) in JSONValue: \(lhs)")
    }
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [A] {
    if let result: [A] = (lhs <? rhs) {
        return result
    }
    else {
        return error("Could not find array at keypath \(rhs) in JSONValue: \(lhs)")
    }
}

public func <! <A: FromJSON where A.T == A>(lhs: JSONValue?, rhs: JSONKeypath) -> [String: A] {
    if let result: [String: A] = (lhs <? rhs) {
        return result
    }
    else {
        return error("Could not find dictionary at keypath \(rhs) in JSONValue: \(lhs)")
    }
}

/// Encoding operators

//infix operator ?> {}
//infix operator ??> {}
//infix operator !> {}