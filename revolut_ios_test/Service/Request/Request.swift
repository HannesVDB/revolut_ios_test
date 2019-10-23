//
//  Request.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

protocol Request {
    /// The url you want to send a request to. This url can be both a relative as a absolute url. In case of
    /// a relative url we prepend it with the base url defined in the configuration.
    var url: URL? { get }
    /// The HTTP method that should be used for this request.
    var method: RequestMethod { get }
    /// Set the url query for this request.
    var query: [String: String]? { get }
    /// Set the headers for this request.
    var headers: [String: String]? { get }
}

extension Request {
    var query: [String: String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
}
