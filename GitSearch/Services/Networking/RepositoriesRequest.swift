//
//  RepositoriesRequest.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

enum RepositoriesRequest {
    case getRepositories(query: String)
}

extension RepositoriesRequest: NetworkRequest {
    var method: Method {
        switch self {
        case .getRepositories:
            return .GET
        }
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.github.com"
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/search/repositories"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .getRepositories(let query):
            return ["q": query]
        }
    }
}
