//
//  UIViewController+describing.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

extension UIViewController {
    class var name: String {
        return String(describing: self)
    }
}
