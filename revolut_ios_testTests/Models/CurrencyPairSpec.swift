//
//  CurrencyPairSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class CurrencyPairSpec: XCTestCase {

    var sut: CurrencyPair!
    var currency: Currency!
    var comparisonCurrency: Currency!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        currency = Currency(abbreviation: "EUR")
        comparisonCurrency = Currency(abbreviation: "USD")
        sut = CurrencyPair(currency: currency, comparisonCurrency: comparisonCurrency)
    }
    
    func testPairShouldHaveTheCorrectValues() {
        XCTAssertEqual(sut.currency?.abbreviation, currency.abbreviation)
        XCTAssertEqual(sut.comparisonCurrency?.abbreviation, comparisonCurrency.abbreviation)
    }
    
    func testPairShouldHaveTheCorrectKey() {
        XCTAssertEqual(sut.key, "EURUSD")
    }
}
