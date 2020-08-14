//
//  UIViewController+Load.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Assign the current view controller as the `rootViewController` of the `keyWindow`. When set
    /// initialize the view.
    func load() {
        UIApplication.shared.keyWindow?.rootViewController = self
        _ = view
    }
    
    func preloadView() {
        _ = view
    }
}
