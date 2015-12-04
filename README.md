 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/typelift/Tyro.svg?branch=master)](https://travis-ci.org/typelift/Tyro)
[![Gitter chat](https://badges.gitter.im/DPVN/chat.png)](https://gitter.im/typelift/general?utm_source=share-link&utm_medium=link&utm_campaign=share-link)

Tyro
======

Tyro is a Swift library for Functional JSON parsing and encoding. 

Introduction
------------

Tyro has roots in [Swiftz](https://github.com/typelift/Swiftz). It draws inspiration from [Aeson](https://github.com/bos/aeson) (from [Haskell](https://www.haskell.org)) and [Argo](https://github.com/thoughtbot/Argo). In Greek mythology, Tyro is the father of Aeson.

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
    let optionalNickname: String?
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
        let optionalNickname: String?? = j <?? "optionalNickname"

        return (curry(User.init)
            <^> id
            <*> name
            <*> age
            <*> tweets
            <*> profile
            <*> balance
            <*> latitude
            <*> longitude
            <*> admin
            <*> optionalNickname).toEither(.Custom("Could not create user"))
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
        && lhs.optionalNickname == rhs.optionalNickname
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

Setup
-----

To add Tyro to your application:

**Using Carthage**

- Add Tyro to your Cartfile
- Run `carthage update`
- Drag the relevant copy of Tyro into your project.
- Expand the Link Binary With Libraries phase
- Click the + and add Tyro
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to `Frameworks`
- Click the + and add Tyro

**Using Git Submodules**

- Clone Tyro as a submodule into the directory of your choice
- Run `git submodule init -i --recursive`
- Drag `Tyro.xcodeproj` or `Tyro-iOS.xcodeproj` into your project tree as a subproject
- Under your project's Build Phases, expand Target Dependencies
- Click the + and add Tyro
- Expand the Link Binary With Libraries phase
- Click the + and add Tyro
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to `Frameworks`
- Click the + and add Tyro
 

System Requirements
===================

Tyro supports OS X 10.10+ and iOS 8.0+.

License
=======

Tyro is released under the BSD license.
