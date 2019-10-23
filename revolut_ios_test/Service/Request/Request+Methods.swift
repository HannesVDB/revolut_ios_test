//
//  Request+Methods.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

extension Request {

    func makeURLRequest(with baseURL: URL?) throws -> URLRequest {
        let url = try makeURL(with: baseURL)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.httpMethod
        return urlRequest
    }
    
    private func makeURL(with baseURL: URL?) throws -> URL {
        // A correct url should be set. And when this is the case we alreay try to append the query
        // to this url.
        guard
            let url = url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw BackendError.invalidURL
        }
        
        var requestURL: URL
        if components.host != nil {
            // When the url is an absolure url, just use this url.
            requestURL = url
        } else if let baseURL = baseURL {
            // When the url is a relative url we should have a base url defined.
            let newURL = baseURL.appendingPathComponent(components.path)
            requestURL = newURL
        } else {
            throw BackendError.invalidURL
        }
        // Append the original query paramters to the new request url.
        var requestComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
        requestComponents?.queryItems = components.queryItems
        guard let correctURL = requestComponents?.url else {
            throw BackendError.invalidURL
        }
        
        // Return the relative url appended to the base url.
        return correctURL.appendingQuery(from: self)
    }
}

fileprivate extension URL {
    func appendingQuery(from request: Request) -> URL {
        guard
            let query = request.query,
            var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        
        let queryItems: [URLQueryItem] = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        // When the initial url doesn't contain query items we set the request's items. Otherwise we append the
        // items to the existing ones.
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        return urlComponents.url ?? self
    }
}
