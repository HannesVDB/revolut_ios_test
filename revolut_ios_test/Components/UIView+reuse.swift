//
//  UIView+reuse.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

extension UIView {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
