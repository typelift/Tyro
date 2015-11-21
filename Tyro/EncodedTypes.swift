//
//  EncodedTypes.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct FromJSONArray<A, B : FromJSON where B.T == A>: FromJSON {
    public typealias T = [A]
    public static func fromJSON(value : JSONValue) -> Either<JSONError, [A]> {
        switch value {
        case .Array(let values):
            return values.flatMap({ B.fromJSON($0) }).lift().either(onLeft : { .Left(.Array($0)) }, onRight : { .Right($0) })
        default:
            return .Left(.TypeMismatch("\(JSONValue.Array.self)", "\(value.dynamicType.self)"))
        }
    }
}

public struct ToJSONArray<A, B : ToJSON where B.T == A>: ToJSON {
    public typealias T = [A]
    
    public static func toJSON(value : T) -> Either<JSONError, JSONValue> {
        return value.flatMap({ B.toJSON($0) }).lift().either(onLeft : { .Left(.Array($0)) }, onRight : { .Right(.Array($0)) })
    }
}

public struct FromJSONDictionary<A, B : FromJSON where B.T == A>: FromJSON {
    public typealias T = [Swift.String : A]
    public static func fromJSON(value : JSONValue) -> Either<JSONError, [Swift.String : A]> {
        switch value {
        case .Object(let value):
            return value.flatMap({ B.fromJSON($0) }).lift().either(onLeft : { .Left(.Array($0)) }, onRight : { .Right($0) })
        default:
            return .Left(.TypeMismatch("\(JSONValue.Object.self)", "\(value.dynamicType.self)"))
        }
    }
}

public struct ToJSONDictionary<A, B : ToJSON where B.T == A>: ToJSON {
    public typealias T = [String : A]
    
    public static func toJSON(value : T) -> Either<JSONError, JSONValue> {
        return value.flatMap({ B.toJSON($0) }).lift().either(onLeft : { .Left(.Array($0)) }, onRight : { .Right(.Object($0)) })
    }
}
