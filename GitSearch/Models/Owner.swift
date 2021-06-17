//
//  Owner.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/17/21.
//

import Foundation

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}

