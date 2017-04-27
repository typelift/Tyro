//
//  User.swift
//  Tyro
//
//  Created by Matthew Purland on 11/17/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import Foundation

import Swiftz
@testable import Tyro

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
    static func fromJSON(_ j: JSONValue) -> Either<JSONError, User> {
        let id: UInt64? = j <? "id"
        let name: String? = j <? "name"
        let age: Int? = j <? "age"
        let tweets: [String]? = j <? "tweets"
        let profile: String? = j <? ("attributes" <> "profile") // A nested keypath
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

func == (lhs: User?, rhs: User?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    }
    else {
        return false
    }
}
