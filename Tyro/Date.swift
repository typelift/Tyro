//
//  Date.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

//public protocol DateTimestampJSONConvertible: JSON {
//}
//
//extension DateTimestampJSONConvertible where Self: NSDate {
//    public static func fromJSON(x: JSONValue) -> NSDate? {
//        switch x {
//        case .JSONNumber(let value):
//            return NSDate(timeIntervalSince1970: value.doubleValue / 1000.0)
//        default:
//            return nil
//        }
//    }
//    
//    public static func toJSON(date: NSDate) -> JSONValue {
//        return JSONValue.JSONNumber(date.timeIntervalSince1970 * 1000.0)
//    }
//}