//
//  Types.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

extension Bool : JSON {
    public static func fromJSON(x : JSONValue) -> Bool? {
        switch x {
        case .JSONNumber(false),
        .JSONNumber(0):
            return false
        case .JSONNumber(true),
        .JSONNumber(1):
            return true
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : Bool) -> JSONValue {
        return JSONValue.JSONNumber(xs)
    }
}

extension Int : JSON {
    public static func fromJSON(x : JSONValue) -> Int? {
        switch x {
        case let .JSONNumber(n):
            return n as Int
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : Int) -> JSONValue {
        return JSONValue.JSONNumber(xs)
    }
}

extension Int64 : JSON {
    public static func fromJSON(x : JSONValue) -> Int64? {
        switch x {
        case let .JSONNumber(n):
            return n.longLongValue
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : Int64) -> JSONValue {
        return JSONValue.JSONNumber(NSNumber(longLong: xs))
    }
}

extension UInt64 : JSON {
    public static func fromJSON(x : JSONValue) -> UInt64? {
        switch x {
        case let .JSONNumber(n):
            return n.unsignedLongLongValue
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : UInt64) -> JSONValue {
        return JSONValue.JSONNumber(NSNumber(unsignedLongLong: xs))
    }
}

extension Double : JSON {
    public static func fromJSON(x : JSONValue) -> Double? {
        switch x {
        case let .JSONNumber(n):
            return n as Double
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : Double) -> JSONValue {
        return JSONValue.JSONNumber(xs)
    }
}

extension Float : JSON {
    public static func fromJSON(x : JSONValue) -> Float? {
        switch x {
        case let .JSONNumber(n):
            return n as Float
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : Float) -> JSONValue {
        return JSONValue.JSONNumber(xs)
    }
}

extension NSNumber : JSON {
    public class func fromJSON(x : JSONValue) -> NSNumber? {
        switch x {
        case let .JSONNumber(n):
            return n
        default:
            return nil
        }
    }
    
    public class func toJSON(xs : NSNumber) -> JSONValue {
        return JSONValue.JSONNumber(xs)
    }
}

extension String : JSON {
    public static func fromJSON(x : JSONValue) -> String? {
        switch x {
        case let .JSONString(n):
            return n
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : String) -> JSONValue {
        return JSONValue.JSONString(xs)
    }
}

// or unit...
extension NSNull : JSON {
    public class func fromJSON(x : JSONValue) -> NSNull? {
        switch x {
        case .JSONNull:
            return NSNull()
        default:
            return nil
        }
    }
    
    public class func toJSON(xs : NSNull) -> JSONValue {
        return .JSONNull
    }
}