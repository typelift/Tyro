 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/mpurland/Tyro.svg?branch=master)](https://travis-ci.org/mpurland/Tyro)
[![Gitter chat](https://badges.gitter.im/DPVN/chat.png)](https://gitter.im/typelift/general?utm_source=share-link&utm_medium=link&utm_campaign=share-link)

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
import Swiftz
import Tyro

// User example
struct User {
    let id: UInt64
    let name: String
    let age: Int
    let tweets: [String]
    let profile: String
    let balance: Double
    let latitude: Double
    let longitude: Double
    let admin: Bool

    static func create(id: UInt64)(name: String)(age: Int)(tweets: [String])(profile: String)(balance: Double)(latitude: Double)(longitude: Double)(admin: Bool) -> User {
        return User(id: id, name: name, age: age, tweets: tweets, profile: profile, balance: balance, latitude: latitude, longitude: longitude, admin: admin)
    }
}

extension User: FromJSON {
    static func fromJSON(j: JSONValue) -> Either<JSONError, User> {
        let id: UInt64? = j <? "id"
        let name: String? = j <? "name"
        let age: Int? = j <? "age"
        let tweets: [String]? = j <? "tweets"
        let profile: String? = j <? "attributes" <> "profile" // A nested keypath
        let balance: Double? = j <? "balance"
        let latitude: Double? = j <? "latitude"
        let longitude: Double? = j <? "longitude"
        let admin: Bool? = j <? "admin"

        return (User.create
            <^> id
            <*> name
            <*> age
            <*> tweets
            <*> profile
            <*> balance
            <*> latitude
            <*> longitude
            <*> admin).toEither(.Custom("Could not create user"))
    }
}

extension User: Equatable {}

func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.age == rhs.age
        && lhs.tweets == rhs.tweets
        && lhs.profile == rhs.profile
        && lhs.balance == rhs.balance
        && lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
        && lhs.admin == rhs.admin
}

func == (lhs: User?, rhs: User?) -> Bool {
    if let lhs = lhs, rhs = rhs {
        return lhs == rhs
    }
    else {
        return false
    }
}


let userJson = "{\"id\": 103622342330925644, \"name\": \"Matthew Purland\", \"age\": 30, \"tweets\": [\"Hello from Tyro\"], \"attributes\": {\"profile\": \"Test Profile\"}, \"balance\": 102.30, \"admin\": true, \"latitude\": 31.75, \"longitude\": 31.75}"

//: The JSON as defined above will decode to a User object, if not it will return nil.
let user: User? = userJson.toJSON?.value()
```
