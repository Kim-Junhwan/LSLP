//
//  CreatorDTO.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/01.
//

import Foundation

struct CreatorDTO: Decodable {
    let id: String
    let nick: String
    let profileImagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick
        case profileImagePath = "profile"
    }
}
