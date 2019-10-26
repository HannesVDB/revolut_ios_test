//
//  CurrencyLabel.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrencyLabel: UILabel {
    
    func set(value: Double) {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        guard let string = formatter.string(from: NSNumber(value: value)) else { return }
        var mutableString: NSMutableAttributedString = NSMutableAttributedString()
        mutableString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        mutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location:string.count - 2,length:2))
        self.attributedText = mutableString
    }
}
