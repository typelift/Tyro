//
//  EncodedTypes.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

public struct ArrayFormatter<F: FromJSON, T: ToJSON> { // where F.T: FromJSON, T.T: ToJSON
    public typealias FT = [F.T]
    public typealias TT = [T.T]
    
    public static var sharedFormatter: ArrayFormatter<F, T> {
        return self.init()
    }
}

extension ArrayFormatter: FromJSONFormatter {
    public func fromJSON(value: JSONValue) -> Either<JSONError, FT> {
        
        let result: Either<JSONError, T> = value.array?.flatMap { $0.value() }
        return result
//        return Either.Right(value.array)
//        switch value {
//        case .Array(let values):
//            return values.flatMap(A.fromJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right($0) })
//        default:
//            return .Left(.TypeMismatch("\(JSONValue.Array.self)", "\(value.dynamicType.self)"))
//        }

//        switch value {
//        case .Number(0), .Number(false):
//            return .Right(false)
//        case .Number(1), .Number(true):
//            return .Right(true)
//        default:
//            return .Left(.TypeMismatch("\(Bool.self)", "\(value.dynamicType.self)"))
//        }
    }
}

extension ArrayFormatter: ToJSONFormatter {
    public func toJSON(values: TT) -> Either<JSONError, JSONValue> {
//        let jv: JSONValue = .Array(values.flatMap )
//        return .Right(JSONValue.Array(value))
//        return JSONValue.encodeEither(values.Map { JSONValue.encode($0) })
        return values.flatMap({ T.T.toJSON(nil, $0) }).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
        return .Left(.Custom(""))
    }
}

//extension ArrayFormatter: ToJSONFormatter {
//    public func toJSON(value: T) -> Either<JSONError, JSONValue> {
//        return .Right(.Number(value))
//    }
//}

//extension Bool: FormatterFromToJSON {
//    public typealias FromFormatterType = ArrayFormatter
//    public typealias ToFormatterType = ArrayFormatter
//}

public struct FromJSONArray<A, B: FromJSON where B.T == A>: FromJSON {
    public typealias T = [A]
//    public static func fromJSON(value: JSONValue) -> Either<JSONError, [A]> {
//        switch value {
//        case .Array(let values):
//            return values.flatMap(B.fromJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right($0) })
//        default:
//            return .Left(.TypeMismatch("\(JSONValue.Array.self)", "\(value.dynamicType.self)"))
//        }
//    }
    
    public static func fromJSON<F: FromJSONFormatter where F.T == T>(formatter: F, _ value: JSONValue) -> Either<JSONError, T> {
        return fromEitherValue(formatter, value)
//        switch value {
//        case .Array(let values):
//            return values.flatMap({ B.fromJSON(formatter, $0) }).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right($0) })
//        default:
//            return .Left(.TypeMismatch("\(JSONValue.Array.self)", "\(value.dynamicType.self)"))
//        }
    }
}

public struct ToJSONArray<A, B: ToJSON where B.T == A>: ToJSON {
    public typealias T = [A]
    
    public static func toJSON(value: T) -> Either<JSONError, JSONValue> {
        return value.flatMap(B.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Array($0)) })
    }
}

public struct FromJSONDictionary<A, B: FromJSON where B.T == A>: FromJSON {
    public typealias T = [Swift.String: A]
    public static func fromJSON(value: JSONValue) -> Either<JSONError, [Swift.String: A]> {
        switch value {
        case .Object(let value):
            return value.flatMap(B.fromJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right($0) })
        default:
            return .Left(.TypeMismatch("\(JSONValue.Object.self)", "\(value.dynamicType.self)"))
        }
    }
}

public struct ToJSONDictionary<A, B: ToJSON where B.T == A>: ToJSON {
    public typealias T = [String: A]
    
    public static func toJSON(value: T) -> Either<JSONError, JSONValue> {
        return value.flatMap(B.toJSON).lift().either(onLeft: { .Left(.Array($0)) }, onRight: { .Right(.Object($0)) })
    }
}
