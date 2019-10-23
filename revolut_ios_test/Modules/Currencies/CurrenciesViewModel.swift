//
//  CurrenciesViewModel.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

class CurrenciesViewModel {
    
    // MARK: - Handlers
    
    var continueHandler:(() -> Void)?
    
    // MARK: - Translations
    
    // MARK: - Properties
    
    var currencies: [CurrencyCellItem] {
        let serializer = JSONSerializer<[String]>()
        if let items: [String] = try? serializer.objects(from: .currencies) {
            return items.compactMap {
                let currency = Currency(abbreviation: $0)
                let isSelected = selectedCurrency?.abbreviation == $0
                return CurrencyCellItem(currency: currency, isSelected: isSelected)
            }
        }
        return []
    }
    
    var hasCompletedFlow: Bool {
        return selectedCurrency != nil && selectedCompareCurrency != nil
    }
    
    private var selectedCurrency: Currency?
    private var selectedCompareCurrency: Currency?
    
    // MARK: - Init
    
    
    init() {
        
    }
    
    // MARK: - Methods

    func didSelectItem(at row: Int) {
        let selectedItem = currencies[row].currency
        if self.selectedCurrency == nil {
            self.selectedCurrency = selectedItem
        } else if self.selectedCompareCurrency == nil {
            self.selectedCompareCurrency = selectedItem
        }
        continueHandler?()
    }
}

struct CurrencyCellItem {
    var currency: Currency?
    var isSelected: Bool
}
