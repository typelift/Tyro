//
//  EncodedTypes.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation
import Swiftz

// container types should be split
public struct JArrayFrom<A, B : JSONDecodable where B.J == A> : JSONDecodable {
    public typealias J = [A]
    
    public static func fromJSON(x : JSONValue) -> J? {
        switch x {
        case let .JSONArray(xs):
            let r = xs.map(B.fromJSON)
            let rp = mapFlatten(r)
            if r.count == rp.count {
                return rp
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}

public struct JArrayTo<A, B : JSONEncodable where B.J == A> : JSONEncodable {
    public typealias J = [A]
    
    public static func toJSON(xs: J) -> JSONValue {
        return JSONValue.JSONArray(xs.map(B.toJSON))
    }
}

public struct JArray<A, B : JSON where B.J == A> : JSON {
    public typealias J = [A]
    
    public static func fromJSON(x : JSONValue) -> J? {
        switch x {
        case let .JSONArray(xs):
            let r = xs.map(B.fromJSON)
            let rp = mapFlatten(r)
            if r.count == rp.count {
                return rp
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : J) -> JSONValue {
        return JSONValue.JSONArray(xs.map(B.toJSON))
    }
}


public struct JDictionaryFrom<A, B : JSONDecodable where B.J == A> : JSONDecodable {
    public typealias J = Dictionary<String, A>
    
    public static func fromJSON(x : JSONValue) -> J? {
        switch x {
        case let .JSONObject(xs):
            return Dictionary(xs.map({ k, x in
                return (k, B.fromJSON(x)!)
            }))
        default:
            return nil
        }
    }
}

public struct JDictionaryTo<A, B : JSONEncodable where B.J == A> : JSONEncodable {
    public typealias J = Dictionary<String, A>
    
    public static func toJSON(xs : J) -> JSONValue {
        return JSONValue.JSONObject(Dictionary(xs.map({ k, x -> (String, JSONValue) in
            return (k, B.toJSON(x))
        })))
    }
}

public struct JDictionary<A, B : JSON where B.J == A> : JSON {
    public typealias J = Dictionary<String, A>
    
    public static func fromJSON(x : JSONValue) -> J? {
        switch x {
        case let .JSONObject(xs):
            return Dictionary<String, A>(xs.map({ k, x in
                return (k, B.fromJSON(x)!)
            }))
        default:
            return nil
        }
    }
    
    public static func toJSON(xs : J) -> JSONValue {
        return JSONValue.JSONObject(Dictionary(xs.map({ k, x in
            return (k, B.toJSON(x))
        })))
    }
}