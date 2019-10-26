//
//  CDCurrencyPair+CurrencyPair.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import CoreData

extension CDCurrencyPair {
    var model: CurrencyPair {
        var pair = CurrencyPair()
        pair.currency = Currency(abbreviation: self.currencyAbbreviation)
        pair.comparisonCurrency = Currency(abbreviation: self.compareCurrencyAbbreviation)
        pair.dateAdded = self.dateAdded
        return pair
    }
}
