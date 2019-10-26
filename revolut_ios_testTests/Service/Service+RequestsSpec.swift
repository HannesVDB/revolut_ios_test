//
//  Service+RequestsSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class Service_RequestsSpec: XCTestCase {

    var sut: Service!
    fileprivate var session: MockSession!
    var pairs = [CurrencyPair]()
    
    override func setUp() {
        session = MockSession()
        sut = Service(session: session)
        pairs = [CurrencyPair(currency: Currency(abbreviation: "EUR"), comparisonCurrency: Currency(abbreviation: "USD"))]
    }
    
    func testExchangeRateShouldSucceed() {
        session.didSucceed = true
        
        sut.exchangeRate(for: pairs) { response in
            switch response {
            case .failure:
                break
            case .success(let result):
                XCTAssertNotNil(result)
                XCTAssertTrue(result?.count == 1)
                XCTAssertEqual(result?["EURUSD"], 12.13)
            }
        }
    }
    
    func testExchangeRateShouldFail() {
        session.didSucceed = false
        
        sut.exchangeRate(for: pairs) { response in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                break
            }
        }
    }
    
    func testExchangeRateShouldFailWithSerializationError() {
        session.didSucceed = true
        session.data =
        """
        "EURUSD": 123
        """.data(using: .utf8)!
        sut.exchangeRate(for: pairs) { response in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error is BackendError)
            case .success:
                break
            }
        }
    }

}

fileprivate class MockSession: URLSession {
    var cachedUrl: URL?
    var didSucceed = false
    
    var data =
    """
    {
    "EURUSD": 12.13
    }
    """.data(using: .utf8)!
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if didSucceed {
            completionHandler(data, nil, nil)
        } else {
            completionHandler(nil, nil, BackendError.invalidURL)
        }
        return URLSessionDataTask()
    }
}
