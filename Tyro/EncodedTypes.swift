//
//  EncodedTypes.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct FromJSONArray<A, B : FromJSON>: FromJSON where B.T == A {
    public typealias T = [A]
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, [A]> {
        switch value {
        case .Array(let values):
            return values.flatMap(B.fromJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: Either.Right)
        default:
            return .Left(.TypeMismatch("\(JSONValue.Array.self)", "\(type(of: value))"))
        }
    }
}

public struct ToJSONArray<A, B : ToJSON>: ToJSON where B.T == A {
    public typealias T = [A]
    
    public static func toJSON(_ value : T) -> Either<JSONError, JSONValue> {
        return value.flatMap(B.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }
}

public struct FromJSONDictionary<A, B : FromJSON>: FromJSON where B.T == A {
    public typealias T = [Swift.String : A]
    public static func fromJSON(_ value : JSONValue) -> Either<JSONError, [Swift.String : A]> {
        switch value {
        case .Object(let value):
            return value.mapMaybe(B.fromJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: Either.Right)
        default:
            return .Left(.TypeMismatch("\(JSONValue.Object.self)", "\(type(of: value).self)"))
        }
    }
}

public struct ToJSONDictionary<A, B : ToJSON>: ToJSON where B.T == A {
    public typealias T = [String : A]
    
    public static func toJSON(_ value : T) -> Either<JSONError, JSONValue> {
        return value.mapMaybe(B.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }
}
