//
//  Service.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

enum ApiResponse<T: Codable> {
    
    case failure(Error?)
    case success(T?)
    
}

protocol BackendRequesting {
    
    func exchangeRate(for currency: Currency, with comparedCurrency: Currency, completion: ((_ response: ApiResponse<[String: Double]>) -> Void)?)

}

class Service: BackendRequesting {
    
    static let shared = Service()
        
    private init() {

    }
    
    func exchangeRate(for currency: Currency, with comparedCurrency: Currency, completion: ((_ response: ApiResponse<[String: Double]>) -> Void)?) {
        let request = ExchangeRateRequest(currency: currency, comparedCurrency: comparedCurrency)
        do {
            let urlRequest = try request.makeURLRequest(with: URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/"))
            execute(urlRequest, with: JSONSerializer<[String: Double]>()) { response in
                switch response {
                case .failure(let error):
                    completion?(.failure(error))
                case .success(let response):
                    completion?(.success(response))
                }
            }
        } catch {
            completion?(.failure(error))
        }
    }
        
    @discardableResult
    // swiftlint:disable function_parameter_count
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
