//
//  ServiceSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble
import Mockingjay

@testable import revolut_ios_test

class ServiceSpec: QuickSpec {
    override func spec() {
        describe("ServiceSpec") {
            let sut = Service.shared
            
            it("should handle an error") {
                self.stub(http(.get, uri: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=EURUSD"), failure(NSError(domain: "be.vdb", code: 403, userInfo: nil)))
                let request = ExchangeRateRequest(pairs: [CurrencyPair(id: "1", currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"), dateAdded: Date())])
                waitUntil { done in
                    let urlRequest = try! request.makeURLRequest(with: AppConstants.baseURL)
                    let serializer = JSONSerializer<[String: Double]>()
                    sut.execute(urlRequest, with: serializer) { response in
                        switch response {
                        case .failure(let error):
                            expect(error).notTo(beNil())
                        default: break
                        }
                        done()
                    }
                }
            }
            
            it("should handle empty response") {
                self.stub(http(.get, uri: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=EURUSD"), json([:]))
                let request = ExchangeRateRequest(pairs: [CurrencyPair(id: "1", currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"), dateAdded: Date())])
                waitUntil { done in
                    let urlRequest = try! request.makeURLRequest(with: AppConstants.baseURL)
                    let serializer = JSONSerializer<[String: Double]>()
                    sut.execute(urlRequest, with: serializer) { response in
                        switch response {
                        case .success(let result):
                            expect(result).notTo(beNil())
                            expect(result?.isEmpty).to(beTrue())
                        default: break
                        }
                       done()
                    }
                }
            }
            
            it("should handle a response") {
                self.stub(http(.get, uri: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=EURUSD"), json(["EURUSD": 1.1457]))
                let request = ExchangeRateRequest(pairs: [CurrencyPair(id: "1", currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"), dateAdded: Date())])
                waitUntil { done in
                    let urlRequest = try! request.makeURLRequest(with: AppConstants.baseURL)
                    let serializer = JSONSerializer<[String: Double]>()
                    sut.execute(urlRequest, with: serializer) { response in
                        switch response {
                        case .success(let result):
                            expect(result).notTo(beNil())
                            expect(result?.isEmpty).to(beFalse())
                            expect(result?.keys.first).to(equal("EURUSD"))
                            expect(result?.values.first).to(equal(1.1457))
                        default: break
                        }
                       done()
                    }
                }
            }
        }
    }
}
