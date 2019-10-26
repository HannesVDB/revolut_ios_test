//
//  RoundedImageView.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
