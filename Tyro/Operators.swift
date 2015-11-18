//
//  Operators.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//public func <? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> A? {
//    switch lhs {
//    case let .JSONObject(d):
//        return rhs.resolve(d).flatMap(A.fromJSON)
//    default:
//        return nil
//    }
//}
//
//public func <? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [A]? {
//    switch lhs {
//    case let .JSONObject(d):
//        return rhs.resolve(d).flatMap(JArrayFrom<A, A>.fromJSON)
//    default:
//        return nil
//    }
//}
//
//public func <? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [String:A]? {
//    switch lhs {
//    case let .JSONObject(d):
//        return rhs.resolve(d).flatMap(JDictionaryFrom<A, A>.fromJSON)
//    default:
//        return nil
//    }
//}
//
//public func <?? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> A?? {
//    return lhs <? rhs ?? nil
//}
//
//public func <?? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [A]?? {
//    return lhs <? rhs ?? nil
//}
//
//public func <?? <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [String: A]?? {
//    return lhs <? rhs ?? nil
//}
//
//public func <! <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> A {
//    if let r: A = (lhs <? rhs) {
//        return r
//    }
//    return error("Cannot find value at keypath \(rhs) in JSON object \(rhs).")
//}
//
//public func <! <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [A] {
//    if let r: [A] = (lhs <? rhs) {
//        return r
//    }
//    return error("Cannot find array at keypath \(rhs) in JSON object \(rhs).")
//}
//
//public func <! <A: JSONDecodable where A == A.J>(lhs: JSONValue, rhs: JSONKeypath) -> [String:A] {
//    if let r: [String: A] = (lhs <? rhs) {
//        return r
//    }
//    return error("Cannot find object at keypath \(rhs) in JSON object \(rhs).")
//}
