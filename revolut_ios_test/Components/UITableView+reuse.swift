//
//  UITableView+reuse.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(class classType: T.Type) {
        register(classType.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

