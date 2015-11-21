//
//  Error.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation

public protocol JSONErrorType : ErrorType {}

public enum JSONError : JSONErrorType {
    case Array([JSONError])           // array of errors
    case TypeMismatch(String, String) // expected / actual
    case Error(ErrorType, String)     // error / message
    case Custom(String)               // message
}

extension JSONError : CustomStringConvertible {
    public var description : String {
        switch self {
        case .Array(let errors):
            return "JSONError(Array(\"\(errors)\"))"
        case .TypeMismatch(let expected, let actual):
            return "JSONError(TypeMismatch(\"\(expected) is not \(actual)\"))"
        case .Error(let error, let message):
            return "JSONError(Error(\"\(message) error : \(error)\"))"
        case .Custom(let message):
            return "JSONError(Custom(\"\(message)\"))"
        }
    }
}
