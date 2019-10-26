//
//  RequestMethodSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class RequestMethodSpec: XCTestCase {
        
    func testRequestMethodGETShouldHaveTheCorrectValue() {
        XCTAssertEqual(RequestMethod.get.httpMethod, "GET")
    }
    
    func testRequestMethodPOSTShouldHaveTheCorrectValue() {
        XCTAssertEqual(RequestMethod.post.httpMethod, "POST")
    }
    
    func testRequestMethodPUTShouldHaveTheCorrectValue() {
        XCTAssertEqual(RequestMethod.put.httpMethod, "PUT")
    }
}
