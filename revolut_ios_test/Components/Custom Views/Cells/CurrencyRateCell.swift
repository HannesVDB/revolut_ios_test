//
//  CurrencyRateCell.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrencyRateCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var currencyAmountLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    @IBOutlet weak var compareCurrencyAmountLabel: CurrencyLabel!
    @IBOutlet weak var compareCurrencyNameLabel: UILabel!
    
    // MARK: - Properties
    
    var model: CurrencyRateModel? {
        didSet {
            if let currency = model?.currencyPair.currency, let comparedCurrency = model?.currencyPair.comparisonCurrency {
                currencyAmountLabel.text = "1 \(currency.abbreviation ?? "")"
                currencyNameLabel.text = currency.abbreviation
                compareCurrencyNameLabel.text = comparedCurrency.abbreviation
                compareCurrencyAmountLabel.set(value: model?.rate ?? 0)
            }
        }
    }
}
