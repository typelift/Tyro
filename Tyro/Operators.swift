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
    let jv = lhs?.jsonValue
    if let jv = jv?[rhs] {
        let r = B.F.fromJSON(jv).right
        return r
    }
    return nil
}

public func <? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [B.F.T]? {
    switch lhs?.jsonValue?[rhs] {
    case .Some(.Array(let values)): return values.flatMap { B.F.fromJSON($0).right }
    default: return nil
    }
}

public func <? <B: JSONFormatterType> (lhs: B?, rhs: JSONKeypath) -> [String: B.F.T]? {
    switch lhs?.jsonValue?[rhs] {
    case .Some(.Object(let value)): return value.flatMap { B.F.fromJSON($0).right }
    default: return nil
    }
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