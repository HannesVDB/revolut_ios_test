//
//  Service.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

final class Service {
    
    /// Shared as a Singleton to request data from the backend
    static let shared = Service()
    let session: URLSession

    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
        
    @discardableResult
    func execute<T: Codable>(_ urlRequest: URLRequest, with serializer: JSONSerializer<T>, completion: @escaping (_ response: ApiResponse<T>) -> Void) -> URLSessionDataTask {
        // Execute the task.
        let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                completion(ApiResponse.failure(error))
            } else if let data = data, !data.isEmpty {
                do {
                    let value: T? = try serializer.object(data: data)
                    completion(ApiResponse.success(value))
                } catch {
                    completion(ApiResponse.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
    
}
