//
//  CurrencyCompareViewModelSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class CurrencyCompareViewModelSpec: XCTestCase {

    var sut: CurrencyCompareViewModel!
    fileprivate var database: MockCurrenciesPersistence!
    fileprivate var notificationManager: MockNotificationManaging!
    fileprivate var service: MockService!
    fileprivate var defaults: UserDefaults!
    
    override func setUp() {
        database = MockCurrenciesPersistence()
        service = MockService()
        notificationManager = MockNotificationManaging()
        defaults = UserDefaults(suiteName: "revolut_ios_test_suite")!
        sut = CurrencyCompareViewModel(database: database, notificationManager: notificationManager, service: service, userDefaults: defaults)
    }
    
    override func tearDown() {
        defaults.removePersistentDomain(forName: "revolut_ios_test_suite")
    }
    
    func testReloadDataShouldCallService() {
        sut.reloadData()
        XCTAssertTrue(service.serviceCalled)
    }

    func testSuccessfullRequestShouldCallDatabase() {
        service.didSucceed = true
        var completionCalled = false
        sut.reloadData {
            completionCalled = true
            XCTAssertTrue(completionCalled)
        }
        XCTAssertTrue(database.currencyCalled)
    }
    
    func testFailedRequestShouldCallErrorHandler() {
        var errorCalled = false
        service.didSucceed = false
        sut.errorHandler = { _ in
            errorCalled = true
            XCTAssertTrue(errorCalled)
        }
        sut.reloadData()
    }
    
    func testRegisterForUpdatesShouldResetTimer() {
        sut.registerForUpdates()
        XCTAssertNil(sut.timer)
    }
    
    func testRegisterForUpdatesShouldReloadData() {
        sut.registerForUpdates()
        XCTAssertTrue(service.serviceCalled)
    }
    
    func testUnregistershouldResetTimerAndNotifications() {
        sut.unregisterForUpdates()
        XCTAssertNil(sut.timer)
        XCTAssertTrue(notificationManager.removeObserversCalled)
    }
    
    func testHasDataShouldBeCorrect() {
        XCTAssertFalse(sut.hasData)
        service.didSucceed = true
        sut.reloadData()
        XCTAssertTrue(sut.hasData)
    }
    
    func testDeletShouldCallDatabase() {
        service.didSucceed = true
        sut.reloadData()
        sut.delete(at: 0)
        XCTAssertTrue(database.deleteCalled)
    }
    
    func testShouldNotCallDeleteWhenNoItems() {
        sut.delete(at: 0)
        XCTAssertFalse(database.deleteCalled)
    }
}

fileprivate class MockCurrenciesPersistence: MockPersistence {
    
    var persistCalled = false
    var currencyCalled = false
    var deleteCalled = false
    
    override func persist(pair: CurrencyPair) {
        persistCalled = true
    }
    
    override var currencyPairs: [CurrencyPair]? {
        currencyCalled = true
        return [CurrencyPair(currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"))]
    }
    
    override func delete(pair: CurrencyPair) {
        deleteCalled = true
    }
}

fileprivate class MockNotificationManaging: NotificationManaging {
    var removeObserversCalled = false
    var observeCalled = false
    
    func observeNotification(with name: NSNotification.Name, block: @escaping ((Notification) -> Void)) {

    }
    
    func publish(with name: NSNotification.Name, value: Any?) {
        
    }
    
    func removeObservers() {
        removeObserversCalled = true
    }
}

fileprivate class MockService: BackendRequesting {
    
    var serviceCalled = false
    var didSucceed = false
    
    func exchangeRate(for pairs: [CurrencyPair], completion: ((ApiResponse<[String : Double]>) -> Void)?) {
        if !didSucceed {
            completion?(.failure(BackendError.fileError))
        } else {
            completion?(.success(["EUR":1.2]))
        }
        serviceCalled = true
    }
}
