//
//  CurrenciesViewControllerSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test
import UIKit

extension UIViewController {
    func preloadView() {
        _ = view
    }
}

class CurrenciesViewControllerSpec: XCTestCase {

    var sut: CurrenciesViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Currencies", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "CurrenciesViewController") as CurrenciesViewController
        sut.preloadView()
    }

    override func tearDown() {
        sut = nil
    }

    func testCurrenciesViewControllerShouldHaveATableView() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
    }
}
