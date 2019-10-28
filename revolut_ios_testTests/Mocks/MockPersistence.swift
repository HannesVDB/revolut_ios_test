//
//  MockPersistence.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation
@testable import revolut_ios_test

class MockPersistence: Persistence {
    func persist(pair: CurrencyPair) {
        
    }
    
    var currencyPairs: [CurrencyPair]? {
        return nil
    }
    
    func deleteCurrencyPair(_ pair: CurrencyPair) {
        
    }
}
