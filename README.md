Tyro
======

Tyro is a Swift library for Functional JSON parsing and encoding. 

Introduction
------------

Tyro has roots in Swiftz. It draws inspiration from [Aeson](https://github.com/bos/aeson) (from [Haskell](https://www.haskell.org)) and [Argo](https://github.com/thoughtbot/Argo). In Greek mythology, Tyro is the father of Aeson.

How to use
----------

**JSON**

```swift
import protocol Tyro.JSONDecoder
import struct Tyro.JSONKeypath
    
final class User {
	let id : UInt64
	let name : String
	let age : Int
	let tweets : [String]
	let attr : String
	let balance : Double
	let admin : Bool

	init(_ i : UInt64, _ n : String, _ a : Int, _ t : [String], _ r : String, _ b : Double, _ ad : Bool) {
		id = i
		name = n
		age = a
		tweets = t
		attr = r
		balance = b
		admin = ad
	}
}

extension User : JSONDecodable {
	class func fromJSON(x : JSONValue) -> User? {
	let p1 : UInt64? = x <? "id"
	let p2 : String? = x <? "name"
	let p3 : Int? = x <? "age"
	let p4 : [String]? = x <? "tweets"
	let p5 : String? = x <? "attrs" <> "one" // A nested keypath
	let p6 : Double? = x <? "balance"
	let p7 : Bool? = x <? "admin"

	return curry(User.init)
		<^> p1
		<*> p2
		<*> p3
		<*> p4
		<*> p5
		<*> p6
		<*> p7
	}
}

func ==(lhs : User, rhs : User) -> Bool {
	return lhs.id == rhs.id
	&& lhs.name == rhs.name
	&& lhs.age == rhs.age
	&& lhs.tweets == rhs.tweets
	&& lhs.attr == rhs.attr
	&& lhs.balance == rhs.balance
	&& lhs.admin == rhs.admin
}

let userjs = "{\"name\": \"max\", \"age\": 10, \"tweets\": [\"hello\"], \"attrs\": {\"one\": \"1\"}}"

//: The JSON we've decoded works perfectly with the User structure we defined above.  In case it didn't,
//: the user would be nil.
let user : User? = JSONValue.decode(userjs) >>- User.fromJSON // .Some( User("max", 10, ["hello"], "1") )
```
