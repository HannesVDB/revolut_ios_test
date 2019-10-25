//
//  CurrencyCellSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class CurrencyCellSpec: XCTestCase {

    var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        tableView.register(class: CurrencyCell.self)
    }
    
    func testCellShouldBeDequeued() {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier)
        XCTAssertNotNil(cell)
    }
}

class CurrenyRateSpec: XCTestCase {

    var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        tableView.register(class: CurrencyRateCell.self)
    }
    
    func testCellShouldBeDequeued() {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateCell.reuseIdentifier)
        XCTAssertNotNil(cell)
    }
}
