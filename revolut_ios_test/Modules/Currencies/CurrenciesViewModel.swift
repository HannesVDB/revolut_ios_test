//
//  CurrenciesViewModel.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrenciesViewModel {
    
    // MARK: - Handlers
    
    var continueHandler:(() -> Void)?
        
    // MARK: - Properties
    
    var currencies: [CurrencyCellItem] {
        let serializer = JSONSerializer<[String]>()
        if let items: [String] = try? serializer.objects(from: .currencies) {
            return items.compactMap {
                let currency = Currency(abbreviation: $0)
                let isSelected = selectedCurrency?.abbreviation == $0
                return CurrencyCellItem(currency: currency, isSelected: isSelected, image: UIImage(named: $0))
            }
        }
        return []
    }
    
    var hasCompletedFlow: Bool {
        return selectedCurrency != nil && selectedCompareCurrency != nil
    }
    
    private(set) var selectedCurrency: Currency?
    private(set) var selectedCompareCurrency: Currency?
    private let database: Persistence
    private let localStorage: LocalStoring
    
    // MARK: - Init
    
    init(database: Persistence = Database.shared, localStorage: LocalStoring = LocalStorage()) {
        self.database = database
        self.localStorage = localStorage
    }
    
    // MARK: - Methods

    func didSelectItem(at row: Int) {
        let selectedItem = currencies[row].currency
        if self.selectedCurrency == nil {
            self.selectedCurrency = selectedItem
        } else if self.selectedCompareCurrency == nil {
            self.selectedCompareCurrency = selectedItem
            saveCurrencies()
        }
        continueHandler?()
    }
}

private extension CurrenciesViewModel {
    func saveCurrencies() {
        let pair = CurrencyPair(currency: selectedCurrency, comparisonCurrency: selectedCompareCurrency)
        database.persist(pair: pair)
    }
}
