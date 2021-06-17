//
//  Repository.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let htmlUrl: String
    let description: String?
    let language: String?
    let watchers: Int

    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case htmlUrl = "html_url"
        case description = "description"
        case language = "language"
        case watchers = "watchers"
    }
}

