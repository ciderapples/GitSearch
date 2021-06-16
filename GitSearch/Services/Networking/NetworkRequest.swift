//
//  NetworkRequest.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

enum Method: String {
    case GET
}

protocol NetworkRequest {
    var method: Method { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
}

extension NetworkRequest {
    func makeRequest() -> URLRequest? {
        guard let url = makeUrl() else { return nil }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        request.httpMethod = method.rawValue
        return request
    }
    
    private func makeUrl() -> URL? {
        var components = URLComponents()
        components.host = host
        components.scheme = scheme
        components.path = path
                
        switch method {
        case .GET:
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return components.url
    }
}
