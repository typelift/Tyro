//
//  DictionaryExt.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

extension Dictionary {
    /// Initialize a Dictionary from a list of Key-Value pairs.
    init<S : SequenceType where S.Generator.Element == Element>
        (_ seq : S) {
            self.init()
            for (k, v) in seq {
                self[k] = v
            }
    }
    
    public func mapMaybe<B>(transform : Value -> B?) -> [Key : B] {
        var b = [Key : B]()
        
        for (k, v) in map(transform) {
            if let v = v {
                b[k] = v
            }
        }
        return b
    }
}
