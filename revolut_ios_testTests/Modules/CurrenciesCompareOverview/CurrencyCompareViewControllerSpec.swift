//
//  CurrencyCompareViewControllerSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test
import UIKit

class CurrencyCompareViewControllerSpec: XCTestCase {

    var sut: CurrencyCompareViewController!
    fileprivate var viewModel: MockCurrencyCompareViewModel!
    fileprivate var database: MockDatabase!
    fileprivate var service: MockService!
    fileprivate var notificationManager: NotificationManaging!
    
    override func setUp() {
        database = MockDatabase()
        service = MockService()
        notificationManager = MockNotificationManager()
        viewModel = MockCurrencyCompareViewModel(database: database, notificationManager: notificationManager, service: service)
        let storyboard = UIStoryboard(name: "CurrencyCompare", bundle: nil)
        sut = storyboard.instantiateInitialViewController() as? CurrencyCompareViewController
        sut.viewModel = viewModel
        sut.preloadView()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testCurrencyCompareViewControllerShouldHaveATableView() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
    }
    
    func testNumberOfItemsShouldBeCorrect() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testCorrectCellShouldBeDequeued() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.reuseIdentifier, "CurrencyRateCell")
    }
    
    func testDeleteShouldCallViewModel() {
        sut.tableView(sut.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(viewModel.deleteCalled)
    }
    
    func testDeleteShouldNotBeCalledOnViewModelWhenInsert() {
        sut.tableView(sut.tableView, commit: .insert, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(viewModel.deleteCalled)
    }
}

fileprivate class MockCurrencyCompareViewModel: CurrencyCompareViewModel {
    
    var deleteCalled = false
    
    override func delete(at row: Int) {
        deleteCalled = true
    }
}

fileprivate class MockDatabase: MockPersistence {
    override var currencyPairs: [CurrencyPair]? {
        return [CurrencyPair(id: "1", currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"), dateAdded: Date())]
    }
}

fileprivate class MockService: BackendRequesting {
    
    func exchangeRate(for pairs: [CurrencyPair], completion: ((ApiResponse<[String : Double]>) -> Void)?) {
        completion?(ApiResponse.success(["EURUSD": 12.1]))
    }
}

fileprivate class MockNotificationManager: NotificationManaging {
    func observeNotification(with name: NSNotification.Name, block: @escaping ((Notification) -> Void)) {
        
    }
    
    func publish(with name: NSNotification.Name, value: Any?) {
        
    }
    
    func removeObservers() {
        
    }
}
