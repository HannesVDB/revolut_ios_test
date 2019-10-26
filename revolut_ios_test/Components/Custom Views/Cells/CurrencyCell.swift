//
//  CurrencyCell.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var currencyImageView: RoundedImageView!
    @IBOutlet weak var currencyAbbreviationLabel: UILabel!
    
    // MARK: - Properties
    
    var item: CurrencyCellItem? {
        didSet {
            currencyAbbreviationLabel.text = item?.currency?.abbreviation
            contentView.alpha = item?.isSelected == true ? 0.4 : 1.0
            isUserInteractionEnabled = item?.isSelected != true
            currencyImageView.image = item?.image
        }
    }
}
