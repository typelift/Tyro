//
//  JSONValueSpec.swift
//  Tyro
//
//  Created by Robert Widmann on 11/21/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
import Tyro
import SwiftCheck

extension JSONValue : Arbitrary {
	public static var arbitrary: Gen<JSONValue> {
        let t: Gen<UInt> = UInt.arbitrary
        
        return t.flatMap { n in
            switch n % 100 {
            case 0:
                return UInt.arbitrary.flatMap { b in
                    if b % 2 == 0  {
                        return Gen.pure(JSONValue.Array([]))
                    }
                    return [JSONValue].arbitrary.map(JSONValue.Array)
                }
            case 1:
                return UInt.arbitrary.flatMap { b in
                    if b % 2 == 0  {
                        return Gen.pure(JSONValue.Object([:]))
                    }
                    return DictionaryOf<Swift.String, JSONValue>.arbitrary.map { JSONValue.Object($0.getDictionary) }
                }
            case 2:
                return Swift.String.arbitrary.map(JSONValue.String)
            case 3:
                return Bool.arbitrary.map { JSONValue.Number(NSNumber(value: $0))  }
            case 4:
                return Int.arbitrary.map { JSONValue.Number($0 as NSNumber) }
            case 5:
                return Int8.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 6:
                return Int16.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 7:
                return Int32.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 8:
                return Int64.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 9:
                return UInt.arbitrary.map { JSONValue.Number($0 as NSNumber) }
            case 10:
                return UInt8.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 11:
                return UInt16.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 12:
                return UInt32.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 13:
                return UInt64.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 14:
                return Float.arbitrary.map(JSONValue.Number • NSNumber.init)
            case 15:
                return Double.arbitrary.map { JSONValue.Number(NSNumber(value: $0))  }
            default:
                return Gen.pure(JSONValue.Null)
            }
        }
	}
}

func roundTrip<T : FromJSON & ToJSON>(_ : T.Type, _ x : JSONValue) -> Testable {
	
    if let xs = T.fromJSON(x).right.map(T.toJSON) {
		return xs == Either.Right(x)
	}
    
	return Discard()
}

class JSONSpec : XCTestCase {
	let frequentFliers : [Property] = [
//		forAll { (x : JSONValue) in roundTrip(Swift.String.self, x) },
		forAll { (x : JSONValue) in roundTrip(Bool.self, x) },

//		forAll { (x : JSONValue) in roundTrip(Int.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Int8.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Int16.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Int32.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Int64.self, x) },
//		forAll { (x : JSONValue) in roundTrip(UInt.self, x) },
//		forAll { (x : JSONValue) in roundTrip(UInt8.self, x) },
//		forAll { (x : JSONValue) in roundTrip(UInt16.self, x) },
//		forAll { (x : JSONValue) in roundTrip(UInt32.self, x) },
//		forAll { (x : JSONValue) in roundTrip(UInt64.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Float.self, x) },
//		forAll { (x : JSONValue) in roundTrip(Double.self, x) },

		forAll { (x : String) in String.fromJSON(String.toJSON(x).right!).right! ==== x },
		forAll { (x : Bool) in Bool.fromJSON(Bool.toJSON(x).right!).right! ==== x },
		forAll { (x : Int) in Int.fromJSON(Int.toJSON(x).right!).right! ==== x },
		forAll { (x : Int8) in Int8.fromJSON(Int8.toJSON(x).right!).right! ==== x },
		forAll { (x : Int16) in Int16.fromJSON(Int16.toJSON(x).right!).right! ==== x },
		forAll { (x : Int32) in Int32.fromJSON(Int32.toJSON(x).right!).right! ==== x },
		forAll { (x : Int64) in Int64.fromJSON(Int64.toJSON(x).right!).right! ==== x },
		forAll { (x : UInt) in UInt.fromJSON(UInt.toJSON(x).right!).right! ==== x },
		forAll { (x : UInt8) in UInt8.fromJSON(UInt8.toJSON(x).right!).right! ==== x },
		forAll { (x : UInt16) in UInt16.fromJSON(UInt16.toJSON(x).right!).right! ==== x },
		forAll { (x : UInt32) in UInt32.fromJSON(UInt32.toJSON(x).right!).right! ==== x },
		forAll { (x : UInt64) in UInt64.fromJSON(UInt64.toJSON(x).right!).right! ==== x },
		forAll { (x : Double) in Double.fromJSON(Double.toJSON(x).right!).right! ==== x },
		forAll { (x : Float) in Float.fromJSON(Float.toJSON(x).right!).right! ==== x },
	]

	func testProperties() {
		self.frequentFliers.forEach { property("Round trip behaves") <- $0 }
	}
}
