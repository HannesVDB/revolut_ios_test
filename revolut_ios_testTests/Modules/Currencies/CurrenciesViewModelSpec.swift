//
//  CurrenciesViewModelSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class CurrenciesViewModelSpec: XCTestCase {

    var sut: CurrenciesViewModel!
    fileprivate var database: MockCurrenciesPersistence!
    
    override func setUp() {
        database = MockCurrenciesPersistence()
        sut = CurrenciesViewModel(database: database)
    }

    func testCurrenciesShouldHaveTheCorrectValues() {
        let currencies = sut.currencies
        XCTAssertTrue(!currencies.isEmpty)
        XCTAssertEqual(currencies.count, 32)
        let value = currencies.first
        XCTAssertEqual(value?.currency?.abbreviation, "AUD")
    }
    
    func testDidSelectItemShouldReloadView() {
        var handlerCalled = false
        sut.continueHandler = {
            handlerCalled = true
        }
        sut.didSelectItem(at: 0)
        XCTAssertTrue(handlerCalled)
        XCTAssertNotNil(sut.selectedCurrency)
        XCTAssertNil(sut.selectedCompareCurrency)
        XCTAssertFalse(sut.hasCompletedFlow)
    }
    
    func testDidSelectSecondItemShouldCompleteFlow() {
        sut.didSelectItem(at: 0)
        sut.didSelectItem(at: 1)
        XCTAssertNotNil(sut.selectedCompareCurrency)
        XCTAssertTrue(sut.hasCompletedFlow)
    }
    
    func testSaveCurrenciesShouldCallDatabase() {
        sut.didSelectItem(at: 0)
        sut.didSelectItem(at: 1)
        XCTAssertTrue(database.persistCalled)
    }
}

fileprivate class MockCurrenciesPersistence: MockPersistence {
    
    var persistCalled = false
    
    override func persist(pair: CurrencyPair) {
        persistCalled = true
    }
}
