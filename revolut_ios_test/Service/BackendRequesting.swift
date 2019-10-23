//
//  BackendRequesting.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

protocol BackendRequesting {
    /// Fetch the exchange rate for two given currencies
    func exchangeRate(for currency: Currency, with comparedCurrency: Currency, completion: ((_ response: ApiResponse<[String: Double]>) -> Void)?)
}
