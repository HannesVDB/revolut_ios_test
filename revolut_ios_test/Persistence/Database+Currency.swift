//
//  Database+Currency.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation
import CoreData

extension Database {
    func persist(pair: CurrencyPair) {
        guard let object = object(for: CDCurrencyPair.self) else {
            return
        }
        object.setValue(pair.currency?.abbreviation, forKey: "currencyAbbreviation")
        object.setValue(pair.comparisonCurrency?.abbreviation, forKey: "compareCurrencyAbbreviation")
        object.setValue(Date(), forKey: "dateAdded")
        object.setValue(pair.id, forKey: "id")
        save()
    }
    
    var currencyPairs: [CurrencyPair]? {
        let items = fetch(for: CDCurrencyPair.self)
        return items.sorted(by: { $0.dateAdded! > $1.dateAdded! }).compactMap { $0.model }
    }
    
    private func currencyPair(for primaryKey: String) -> CDCurrencyPair? {
        return fetch(for: CDCurrencyPair.self, with: primaryKey)
    }
    
    func deleteCurrencyPair(_ pair: CurrencyPair) {
        guard let pair = currencyPair(for: pair.id) else {
            print("Not found")
            return
        }
        delete(value: pair)
    }
}
