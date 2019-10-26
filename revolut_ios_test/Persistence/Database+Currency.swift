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
        save()
    }
    
    var currencyPairs: [CurrencyPair]? {
        let items = fetch(for: CDCurrencyPair.self)
        return items.sorted(by: { $0.dateAdded! > $1.dateAdded! }).compactMap { $0.model }
    }
}
