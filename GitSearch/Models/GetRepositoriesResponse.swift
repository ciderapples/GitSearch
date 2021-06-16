//
//  GetRepositoriesResponse.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

struct GetRepositoriesResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    enum CodingKeys : String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}
