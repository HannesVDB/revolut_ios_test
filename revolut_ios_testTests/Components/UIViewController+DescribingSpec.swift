//
//  UIViewController+DescribingSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class UIViewController_DescribingSpec: XCTestCase {

    func testViewControllerNameShouldBeCorrect() {
        XCTAssertEqual(MockViewController.name, "MockViewController")
    }
}

fileprivate class MockViewController: UIViewController {
    
}
