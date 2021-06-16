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
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
    }
}
