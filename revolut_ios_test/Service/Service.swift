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
        
    private init() {

    }
        
    @discardableResult
    func execute<T: Codable>(_ urlRequest: URLRequest, with serializer: JSONSerializer<T>, completion: @escaping (_ response: ApiResponse<T>) -> Void) -> URLSessionDataTask {
        // Prepare the session.
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
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
