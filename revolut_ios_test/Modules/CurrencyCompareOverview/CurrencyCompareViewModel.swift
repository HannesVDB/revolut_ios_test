//
//  CurrencyCompareViewModel.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

class CurrencyCompareViewModel {
    
    // MARK: - Handlers
    
    var reloadDataHandler:(() -> Void)?
    
    // MARK: - Translations
    
    // MARK: - Properties
    
    var currencyPairs: [CurrencyPair] {
        return database.currencyPairs ?? []
    }
    
    var hasData: Bool {
        return currencyPairs.count != 0
    }
    
    private let database: Database
    
    // MARK: - Init
    
    init(database: Database = Database.shared) {
        self.database = database
    }
    
    // MARK: - Methods
    
}
