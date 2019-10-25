//
//  UIView+ReuseSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

internal class MockView: UIView {
    
}

class UIView_ReuseSpec: XCTestCase {

    func testMockShouldhaveTheCorrectReuseIdentifier() {
        XCTAssertEqual(MockView.reuseIdentifier, "MockView")
    }

    func testMockNibNameShouldBeCorrect() {
        XCTAssertEqual(MockView.nibName, "MockView")
    }

    func testNibShouldReturntheCorrectItem() {
        let nib = MockCell.nib
        XCTAssertNotNil(nib)
    }
}
