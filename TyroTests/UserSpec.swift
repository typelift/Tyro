//
//  UserSpec.swift
//  Tyro
//
//  Created by Matthew Purland on 11/19/15.
//  Copyright © 2015 TypeLift. All rights reserved.
//

import XCTest
import Swiftz
@testable import Tyro

class UserSpec: XCTestCase {
    let userJson = "{\"id\": 103622342330925644, \"name\": \"Matthew Purland\", \"age\": 30, \"tweets\": [\"Hello from Tyro\"], \"attributes\": {\"profile\": \"Test Profile\"}, \"balance\": 102.30, \"admin\": true, \"latitude\": 31.75, \"longitude\": 31.75}"
    let userJsonWithoutLongitude = "{\"id\": 103622342330925644, \"name\": \"Matthew\", \"age\": 30, \"tweets\": [\"Hello from Tyro\"], \"attributes\": {\"profile\": \"Test Profile\"}, \"balance\": 102.30, \"admin\": true, \"latitude\": 31.75}"
    
    func testDecodeUserEither() {
        let userEither: Either<JSONError, User>? = userJson.toJSON?.valueEither()
        print("User either: \(userEither)")
        XCTAssertNotNil(userEither)
    }
    
    func testDecodeUser() {
        let user: User? = userJson.toJSON?.value()
        XCTAssertNotNil(user)
        
        XCTAssert(user?.id == 103622342330925644)
        XCTAssert(user?.name == "Matthew Purland")
        XCTAssert(user?.age == 30)
        XCTAssert(user?.tweets == ["Hello from Tyro"])
        XCTAssert(user?.profile == "Test Profile")
        XCTAssert(user?.balance == 102.30)
        XCTAssert(user?.admin == true)
        XCTAssert(user?.latitude == 31.75)
        XCTAssert(user?.longitude == 31.75)
    }
    
    func testDecodeUserInvalid() {
        // Longitude is missing, User.fromJSON will return a JSONError
        let user: User? = userJsonWithoutLongitude.toJSON?.value()
        XCTAssertNil(user)
    }
}