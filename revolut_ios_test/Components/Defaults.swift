//
//  Defaults.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 20/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Foundation

protocol LocalStoring {
    func store(value: String, for key: String)
    func store(value: Int, for key: String)
    func string(for key: String) -> String?
    func integer(for key: String) -> Int
}

// This looks like a wrapper but can easily be mocked or injectected when needed
// Easy method to tests
struct LocalStorage: LocalStoring {
    private let defaults = UserDefaults.standard
    
    func store(value: String, for key: String) {
        defaults.set(value, forKey: key)
    }
    
    func store(value: Int, for key: String) {
        defaults.set(value, forKey: key)
    }
    
    func string(for key: String) -> String? {
        return defaults.string(forKey: key)
    }
       
    func integer(for key: String) -> Int {
        return defaults.integer(forKey: key)
    }
}
