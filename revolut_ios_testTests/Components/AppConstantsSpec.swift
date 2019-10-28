//
//  AppConstantsSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class AppConstantsSpec: XCTestCase {

    func testBaseURLShouldBeCorrect() {
        XCTAssertEqual(AppConstants.baseURL?.absoluteString, "https://europe-west1-revolut-230009.cloudfunctions.net/")
    }
    
    func testCoreDataContainerValueShouldBeCorrect() {
        XCTAssertEqual(AppConstants.coreDataContainer, "revolut_ios_test")
    }
    
    func testCurrenciesStoryboardNameShouldBeCorrect() {
        XCTAssertEqual(AppConstants.currenciesStoryboardName, "Currencies")
    }
}
