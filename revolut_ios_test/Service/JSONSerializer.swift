//
//  JSONSerializer.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
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

class JSONSerializer<T: Codable> {
    /// Serialize given data to a codable object
    func object<T: Codable>(data: Data, with decoder: JSONDecoder? = JSONDecoder()) throws -> T? {
        do {
            let item = try decoder?.decode(T.self, from: data)
            return item
        } catch {
            print(error)
            throw BackendError.serializationError
        }
    }
    
    func objects<T: Codable>(from file: DummyFileType, with decoder: JSONDecoder? = JSONDecoder()) throws -> [T]? {
        guard let path = Bundle.main.path(forResource: file.filename, ofType: "json"),
            let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8),
            let jsonData = jsonString.data(using: .utf8) else {
            throw BackendError.fileError
        }
        
        do {
            let items = try decoder?.decode([T].self, from: jsonData)
            return items
        } catch {
            throw BackendError.serializationError
        }
    }
}
