//
//  ExchangeRateRequest.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

struct ExchangeRateRequest: Request {
    
    let currency: Currency
    let comparedCurrency: Currency
    
    var url: URL? {
        return URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios")
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var query: [String : String]? {
        guard let currencyAbr = currency.abbreviation, let comparedAbr = comparedCurrency.abbreviation else {
            return nil
        }
        return [
            "pairs": "\(currencyAbr)\(comparedAbr)",
//            "pairs": "\(comparedAbr)\(currencyAbr)"
        ]
    }
}
