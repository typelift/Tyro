//
//  Operators.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

// JSONFormatterType decoding operators

infix operator <?? : JSONPrecedence

public func <? (lhs : JSONValue?, rhs : JSONKeypath) -> JSONValue? {
    return lhs?[rhs]
}

public func <? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> B.DecodedType? {
    return (lhs?.decode <*> lhs?.jsonValue?[rhs]) ?? nil
}

public func <? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> [B.DecodedType]? {
    return lhs?.jsonValue?[rhs]?.array.flatMap { $0.flatMap { lhs?.decode($0) } }
}

public func <? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> [String : B.DecodedType]? {
    return lhs?.jsonValue?[rhs]?.object.flatMap { $0.mapMaybe { lhs?.decode($0) } }
}

public func <?? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> B.DecodedType?? {
    return (lhs <? rhs)
}

public func <?? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> [B.DecodedType]?? {
    return (lhs <? rhs) 
}

public func <?? <B : JSONFormatterType> (lhs : B?, rhs : JSONKeypath) -> [String : B.DecodedType]?? {
    return (lhs <? rhs) 
}

/// JSONValue decoding operators

public func <? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> A? where A.T == A {
    return lhs?[rhs]?.value()
}

public func <? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> [A]? where A.T == A {
    return lhs?[rhs]?.value()
}

public func <? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> [String : A]? where A.T == A {
    return lhs?[rhs]?.value()
}

public func <?? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> A?? where A.T == A {
    return lhs <? rhs
}

public func <?? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> [A]?? where A.T == A {
    return lhs <? rhs
}

public func <?? <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) -> [String : A]?? where A.T == A {
    return lhs <? rhs
}

public func <! <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) throws -> A where A.T == A {
    if let result : A = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue : \(lhs)")
    }
}

public func <! <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) throws -> [A] where A.T == A {
    if let result : [A] = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue : \(lhs)")
    }
}

public func <! <A : FromJSON>(lhs : JSONValue?, rhs : JSONKeypath) throws -> [String : A] where A.T == A {
    if let result : [String : A] = (lhs <? rhs) {
        return result
    }
    else {
        throw JSONError.Custom("Could not find value at keypath \(rhs) in JSONValue : \(lhs)")
    }
}
