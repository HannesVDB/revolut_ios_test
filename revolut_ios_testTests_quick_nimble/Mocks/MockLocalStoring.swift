//
//  MockLocalStoring.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 20/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Foundation
@testable import revolut_ios_test

class MockLocalStoring: LocalStoring {
    
    private var storage = [String: Any?]()
    
    func store(value: String, for key: String) {
        storage[key] = value
    }
    
    func store(value: Int, for key: String) {
        storage[key] = value
    }
    
    func string(for key: String) -> String? {
        return storage[key] as? String
    }
    
    func integer(for key: String) -> Int {
        return storage[key] as? Int ?? 0
    }
    
}
