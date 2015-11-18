//
//  EitherExt.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

func | <L, R>(either: Either<L, R>?, @autoclosure(escaping) f: () -> R?) -> R? {
    return either?.either(onLeft: { _ in f() }, onRight: identity)
}

extension Either {
    var right: R? {
        switch self {
        case .Right(let r): return r
        default: return nil
        }
    }
    
    var left: L? {
        switch self {
        case .Left(let l): return l
        default: return nil
        }
    }
    
    func fmap<L, RA, RB>(f : RA -> RB, e : Either<L, RA>) -> Either<L, RB> {
        return f <^> e
    }
}
