//
//  ExchangeRateRequest.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

struct ExchangeRateRequest: Request {
    let pairs: [CurrencyPair]
    
    var url: URL? {
        var url = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?"
        let items = pairs.compactMap { "pairs=\($0.key)"}
        items.enumerated().forEach { item in
            var component = item.element
            if item.offset != items.count - 1 {
                component.append("&")
            }
            url.append(component)
        }
        return URL(string: url)
    }
    
    var method: RequestMethod {
        return .get
    }
}
