//
//  CurrencyRateCellSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import revolut_ios_test

class CurrencyRateCellSpec: QuickSpec {
    override func spec() {
        describe("CurrencyRateCell") {
            var sut: MockedTableViewController<CurrencyRateCell>!
            var dataSource: DataSource!

            context("Initial state") {
                beforeEach {
                    sut = MockedTableViewController()
                    dataSource = DataSource()
                    sut.tableView?.dataSource = dataSource
                    sut.load()
                }
                
                it("should have the correct initial state") {
                    expect(sut.snapshotObject) == snapshot()
                }
            }
            
            context("Data provided") {
                beforeEach {
                    sut = MockedTableViewController()
                    dataSource = DataSource()
                    dataSource.model = CurrencyRateModel(currencyPair: CurrencyPair(id: "1", currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"), dateAdded: Date()), rate: 1.234)
                    sut.tableView?.dataSource = dataSource
                    sut.load()
                }
                
                it("should show the values") {
                    expect(sut.snapshotObject) == snapshot()
                }
            }
        }
    }
}

private class DataSource: NSObject, UITableViewDataSource {
    
    var model: CurrencyRateModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CurrencyRateCell
        cell.model = model
        return cell
    }
}
