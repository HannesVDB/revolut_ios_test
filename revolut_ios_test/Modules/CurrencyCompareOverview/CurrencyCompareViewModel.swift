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
    var errorHandler:((_ error: Error?) -> Void)?
    
    // MARK: - Translations
    
    // MARK: - Properties
    
    private(set) var currencyPairs: [CurrencyRateModel]? {
        didSet {
            reloadDataHandler?()
        }
    }
    
    var hasData: Bool {
        guard let pairs = currencyPairs else {
            return false
        }
        return pairs.count != 0
    }
    
    private let database: Database
    
    // MARK: - Init
    
    init(database: Database = Database.shared) {
        self.database = database
    }
    
    // MARK: - Methods
    
    func reloadData() {
        let currencyPairs = database.currencyPairs ?? []
        Service.shared.exchangeRate(for: currencyPairs) { reponse in
            switch reponse {
            case .success(let response):
                guard let response = response else { return }
                self.currencyPairs = self.database.currencyPairs?.compactMap { CurrencyRateModel(currencyPair: $0, rate: response[$0.key]) }
            case .failure(let error):
                self.errorHandler?(error)
            }
        }
    }
}

struct CurrencyRateModel {
    var currencyPair: CurrencyPair
    var rate: Double?
}
