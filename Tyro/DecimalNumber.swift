//
//  DecimalNumber.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public protocol DecimalNumberJSONConvertibleType: FromJSON, ToJSON {
}

extension DecimalNumberJSONConvertibleType {
    public typealias T = NSDecimalNumber
    
    public static func fromJSON(value: JSONValue) -> Either<JSONError, NSDecimalNumber> {
        switch value {
        case .Number(let n):
            return .Right(NSDecimalNumber(decimal: n.decimalValue))
        default:
            return .Left(.TypeMismatch("NSDecimalNumber JSON", "\(value.dynamicType.self)"))
        }
    }
    
    public static func toJSON(dn: NSDecimalNumber) -> Either<JSONError, JSONValue> {
        return .Right(.Number(dn))
    }
}

struct DecimalNumberJSONFormatter: DecimalNumberJSONConvertibleType {
    private init() {}
}
