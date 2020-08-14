//
//  CurrenciesOverviewUISpec.swift
//  revolut_ios_testUITests
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import XCTest

@testable import revolut_ios_test

class CurrenciesOverviewUISpec: XCTestCase {

    var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        // Since UI tests are more expensive to run, it's usually a good idea
        // to exit if a failure was encountered
        continueAfterFailure = false

        app = XCUIApplication()

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }
    
    func testOpenApp() {
        app.launch()
        
        let app = XCUIApplication()
        app.buttons["Add currency pair"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AUD"].tap()
        tablesQuery.staticTexts["DKK"].tap()
    }
    
    func testOpenAppAndScroll() {
            app.launch()
            
            let app = XCUIApplication()
            app.buttons["Add currency pair"].tap()
            app.swipeUp()
    
            let tablesQuery = app.tables
            tablesQuery.staticTexts["EUR"].tap()
            app.swipeUp()
            tablesQuery.staticTexts["GBP"].tap()
        }

}
