//
//  JSONSerializer.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

class JSONSerializer<T: Codable> {
    
    func object<T: Codable>(data: Data, with decoder: JSONDecoder? = JSONDecoder()) throws -> T? {
        do {
            let item = try decoder?.decode(T.self, from: data)
            return item
        } catch {
            print(error)
            fatalError("Something wrong")
        }
    }
}
