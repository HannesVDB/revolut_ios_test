//
//  CurrencyPair.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

struct CurrencyPair {
    var id: String = UUID().uuidString
    var currency: Currency?
    var comparisonCurrency: Currency?
    var dateAdded: Date = Date()
}

extension CurrencyPair {
    var key: String {
        return "\(currency?.abbreviation ?? "")\(comparisonCurrency?.abbreviation ?? "")"
    }
}
