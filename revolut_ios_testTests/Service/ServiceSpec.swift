//
//  ServiceSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class ServiceSpec: XCTestCase {
    
    var sut: Service!
    fileprivate var mockSession: MockSession!
    
    override func setUp() {
        mockSession = MockSession()
        sut = Service(session: mockSession)
    }
    
    func testExecuteShouldCompleteWithFailure() {
        let url = URL(string: "https://www.relative.be/")!
        let request = URLRequest(url: url)
        let serializer = JSONSerializer<[String]>()
        mockSession.didSucceed = false
        sut.execute(request, with: serializer) { response in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                break
            }
        }
    }
    
    func testExecuteShouldCompleteWithSuccess() {
        let url = URL(string: "https://www.relative.be/")!
        let request = URLRequest(url: url)
        let serializer = JSONSerializer<[String]>()
        mockSession.didSucceed = true
        sut.execute(request, with: serializer) { response in
            switch response {
            case .failure:
                break
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertTrue(data?.count == 1)
            }
        }
    }
}

fileprivate class MockSession: URLSession {
    var cachedUrl: URL?
    var didSucceed = false
    
    let data =
    """
    [ "EUR" ]
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
