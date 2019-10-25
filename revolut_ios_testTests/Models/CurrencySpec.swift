//
//  CurrencySpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class CurrencySpec: XCTestCase {

    var sut: Currency?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let json = """
        {
            "abbreviation": "EUR"
        }
        """
        let data = json.data(using: .utf8)
        sut = try? JSONDecoder().decode(Currency.self, from: data!)
    }

    func testJSONShouldBeCorrectlyDecoded() {
        XCTAssertNotNil(sut)
    }
    
    func testCurrencyShouldHaveTheCorrectAbbreviation() {
        XCTAssertEqual(sut?.abbreviation, "EUR")
    }
}
