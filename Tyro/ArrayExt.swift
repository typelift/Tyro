//
//  ArrayExt.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

/// MARK: Sequence and SequenceType extensions

extension SequenceType {
    /// Maps the array of  to a dictionary given a transformer function that returns
    /// a (Key, Value) pair for the dictionary, if nil is returned then the value is
    /// not added to the dictionary.
    public func mapLabelPairs<Key: Hashable, Value>(f: Generator.Element -> (Key, Value)?) -> [Key: Value] {
        return Dictionary(flatMap(f))
    }
    
    /// Creates a dictionary of Key-Value pairs generated from the transformer function returning the key (the label)
    /// and pairing it with that element.
    public func mapLabel<K: Hashable>(f: Generator.Element -> K) -> [K: Generator.Element] {
        return Dictionary(map { (f($0), $0) })
    }
}