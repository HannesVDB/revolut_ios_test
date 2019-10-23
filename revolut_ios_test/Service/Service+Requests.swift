//
//  Service+Requests.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

extension Service: BackendRequesting {
    func exchangeRate(for currency: Currency, with comparedCurrency: Currency, completion: ((_ response: ApiResponse<[String: Double]>) -> Void)?) {
        let request = ExchangeRateRequest(currency: currency, comparedCurrency: comparedCurrency)
        do {
            let urlRequest = try request.makeURLRequest(with: AppConstants.baseURL)
            let serializer = JSONSerializer<[String: Double]>()
            execute(urlRequest, with: serializer) { response in
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
}
