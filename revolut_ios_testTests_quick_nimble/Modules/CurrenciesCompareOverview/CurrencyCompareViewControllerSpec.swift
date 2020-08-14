
//
//  CurrencyCompareViewControllerSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import revolut_ios_test

class CurrencyCompareViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CurrencyCompareViewController") {
            var sut: CurrencyCompareViewController!
            var viewModel: MockCurrencyCompareViewModel!
            var database: MockDatabase!
            var service: MockService!
            var notificationManager: NotificationManaging!
            
            beforeEach {
                database = MockDatabase()
                service = MockService()
                notificationManager = MockNotificationManager()
                viewModel = MockCurrencyCompareViewModel(database: database, notificationManager: notificationManager, service: service)
                let storyboard = UIStoryboard(name: "CurrencyCompare", bundle: nil)
                sut = storyboard.instantiateInitialViewController() as? CurrencyCompareViewController
                sut.viewModel = viewModel
                sut.preloadView()
            }
            
            it("should have a correct view controller") {
                expect(sut.view) == snapshot()
            }
        }
    }
}

class MockPersistence: Persistence {
    func persist(pair: CurrencyPair) {
        
    }
    
    var currencyPairs: [CurrencyPair]? {
        return nil
    }
    
    func deleteCurrencyPair(_ pair: CurrencyPair) {
        
    }
    
    func deleteAll() {
        
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
