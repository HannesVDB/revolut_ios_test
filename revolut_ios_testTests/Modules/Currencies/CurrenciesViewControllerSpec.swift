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
    fileprivate var viewModel: MockCurrenciesViewModel!
    fileprivate var mockDatabase: MockDatabase!
    fileprivate var mockNavigationController: MockNavigationController!
    
    override func setUp() {
        mockDatabase = MockDatabase()
        viewModel = MockCurrenciesViewModel(database: mockDatabase)
        let storyboard = UIStoryboard(name: "Currencies", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "CurrenciesViewController") as CurrenciesViewController
        sut.viewModel = viewModel
        sut.preloadView()
    }

    override func tearDown() {
        sut = nil
    }

    func testCurrenciesViewControllerShouldHaveATableView() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
    }
    
    func testNumberOfItemsShouldBeCorrect() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testCorrectCellShouldBeDequeued() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.reuseIdentifier, "CurrencyCell")
    }
    
    func testDidSelectRowAtIndexPathShouldCallViewModel() {
        var continueCalled = false
        viewModel.continueHandler = {
            continueCalled = true
        }
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(continueCalled)
        XCTAssertTrue(viewModel.didSelectCalled)
    }
    
    func testDidSelectRowShouldCallReloadWhenCompletedFlow() {
        viewModel.completedFlow = true
        var reloadCalled = false
        sut.reloadHandler = {
            reloadCalled = true
        }
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(reloadCalled)
    }
    
    func testDidSelectRowShouldCallNavigationController() {
        mockNavigationController = MockNavigationController(rootViewController: sut)
        mockNavigationController.preloadView()
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockNavigationController.showCalled)
    }
}

fileprivate class MockCurrenciesViewModel: CurrenciesViewModel {
    
    var didSelectCalled = false
    var completedFlow = false
    
    override var hasCompletedFlow: Bool {
        return completedFlow
    }
    
    override var currencies: [CurrencyCellItem] {
        return [CurrencyCellItem(currency: Currency(abbreviation: "USD"), isSelected: false, image: nil)]
    }
    
    override func didSelectItem(at row: Int) {
        didSelectCalled = true
        continueHandler?()
    }
}

fileprivate class MockDatabase: MockPersistence {
    
}

fileprivate class MockNavigationController: UINavigationController {
    
    var showCalled = false
    
    override func show(_ vc: UIViewController, sender: Any?) {
        showCalled = true
    }
}
