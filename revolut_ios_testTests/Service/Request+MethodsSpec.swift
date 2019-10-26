//
//  Request+MethodsSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class Request_MethodsSpec: XCTestCase {
    
    func testMakeRequestShouldCreateURLRequest() {
        let request = MockRequest()
        let urlRequest = try? request.makeURLRequest(with: URL(string: "https://google.com"))
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://google.com/fetch?a=1")
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
    }

}

fileprivate struct MockRequest: Request {
    var url: URL? {
        return URL(string: "/fetch")
    }
    
    var method: RequestMethod {
        return .post
    }
    
    var query: [String : String]? {
        return ["a": "1"]
    }
}
