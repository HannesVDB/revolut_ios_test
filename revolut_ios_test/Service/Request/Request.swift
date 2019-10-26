//
//  Request.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

protocol Request {
    var url: URL? { get }
    var method: RequestMethod { get }
    var query: [String: String]? { get }
}

extension Request {
    var query: [String: String]? {
        return nil
    }
}
