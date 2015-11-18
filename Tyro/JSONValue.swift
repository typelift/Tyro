//
//  JSONValue.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//public enum JSONValue: CustomStringConvertible {
//    case JSONArray([JSONValue])
//    case JSONObject([String: JSONValue])
//    case JSONString(String)
//    case JSONNumber(NSNumber)
//    case JSONNull
//    
//    public static func from(a: AnyObject) -> JSONValue? {
//        switch a {
//        case let xs as [AnyObject]:
//            return .JSONArray(xs.flatMap(from))
//        case let xs as [String: AnyObject]:
//            return .JSONObject(xs.flatMap(from))
//        case let xs as NSNumber:
//            return .JSONNumber(xs)
//        case let xs as String:
//            return .JSONString(xs)
//        case _ as NSNull:
//            return .JSONNull
//        default:
//            return nil
//        }
//    }
//    
//    private func values() -> NSObject {
//        switch self {
//        case let .JSONArray(xs):
//            return NSArray(array: xs.map { $0.values() })
//        case let .JSONObject(xs):
//            return Dictionary(xs.map({ k, v in
//                return (k, v.values())
//            }))
//        case let .JSONNumber(n):
//            return n
//        case let .JSONString(s):
//            return s
//        case .JSONNull:
//            return NSNull()
//        }
//    }
//    
//    public func encode() -> NSData? {
//        do {
//            // TODO: check s is a dict or array
//            return try NSJSONSerialization.dataWithJSONObject(self.values(), options: NSJSONWritingOptions(rawValue: 0))
//        } catch _ {
//            return nil
//        }
//    }
//    
//    // TODO: should this be optional?
//    public static func decode(s: NSData) -> JSONValue? {
//        let r: AnyObject?
//        do {
//            r = try NSJSONSerialization.JSONObjectWithData(s, options: NSJSONReadingOptions(rawValue: 0))
//        } catch _ {
//            r = nil
//        }
//        
//        if let json = r as? NSObject {
//            return from(json)
//        } else {
//            return nil
//        }
//    }
//    
//    public static func decode(s: String) -> JSONValue? {
//        return JSONValue.decode(s.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
//    }
//    
//    public var description: String {
//        switch self {
//        case .JSONNull:
//            return "JSONNull"
//        case let .JSONString(s):
//            return "JSONString(\(s))"
//        case let .JSONNumber(n):
//            return "JSONNumber(\(n))"
//        case let .JSONObject(o):
//            return "JSONObject(\(o))"
//        case let .JSONArray(a):
//            return "JSONArray(\(a))"
//        }
//    }
//}
//
//// you'll have more fun if you match tuples
//// Equatable
//public func == (lhs: JSONValue, rhs: JSONValue) -> Bool {
//    switch (lhs, rhs) {
//    case (.JSONNull, .JSONNull):
//        return true
//    case let (.JSONString(l), .JSONString(r)) where l == r:
//        return true
//    case let (.JSONNumber(l), .JSONNumber(r)) where l == r:
//        return true
//    case let (.JSONObject(l), .JSONObject(r))
//        where l.elementsEqual(r, isEquivalent: { (v1: (String, JSONValue), v2: (String, JSONValue)) in v1.0 == v2.0 && v1.1 == v2.1 }):
//        return true
//    case let (.JSONArray(l), .JSONArray(r)) where l.elementsEqual(r, isEquivalent: { $0 == $1 }):
//        return true
//    default:
//        return false
//    }
//}
//
//public func != (lhs: JSONValue, rhs: JSONValue) -> Bool {
//    return !(lhs == rhs)
//}
//
//// someday someone will ask for this
////// Comparable
////func <=(lhs: JSValue, rhs: JSValue) -> Bool {
////  return false;
////}
////
////func >(lhs: JSValue, rhs: JSValue) -> Bool {
////  return !(lhs <= rhs)
////}
////
////func >=(lhs: JSValue, rhs: JSValue) -> Bool {
////  return (lhs > rhs || lhs == rhs)
////}
////
////func <(lhs: JSValue, rhs: JSValue) -> Bool {
////  return !(lhs >= rhs)
////}