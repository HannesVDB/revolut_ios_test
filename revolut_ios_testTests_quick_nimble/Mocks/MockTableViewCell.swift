//
//  MockTableViewCell.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import UIKit

@testable import revolut_ios_test

class MockedTableViewController<T: UITableViewCell>: UITableViewController {
    
    init(width: CGFloat = 1024) {
        super.init(style: .plain)
        
        tableView.register(class: T.self)
        tableView.frame = CGRect(x: 0, y: 0, width: width, height: 500)
        tableView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
