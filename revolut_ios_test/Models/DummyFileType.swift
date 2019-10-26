//
//  DummyFileType.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

enum DummyFileType {
    case currencies
    
    var filename: String {
        switch self {
        case .currencies: return "currencies"
        }
    }
}
