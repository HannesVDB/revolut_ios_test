//
//  ExchangeRateRequestSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class ExchangeRateRequestSpec: XCTestCase {

    var sut: ExchangeRateRequest!
    var pairs = [CurrencyPair]()
    
    override func setUp() {
        pairs = [CurrencyPair(currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"))]
        sut = ExchangeRateRequest(pairs: pairs)
    }
    
    func testMethodShouldBeCorrect() {
        XCTAssertEqual(sut.method, RequestMethod.get)
    }
    
    func testURLShouldBeCorrectWithQueryParams() {
        XCTAssertEqual(sut.url?.absoluteString, "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=EURUSD")
    }
    
    func testRequestShouldHaveNoQuery() {
        XCTAssertNil(sut.query)
    }
}
