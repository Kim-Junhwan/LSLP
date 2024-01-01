//
//  WriteContentResponseDTO.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/01.
//

import Foundation

struct WriteContentResponseDTO: Decodable {
    let image: [String]
    let id: String
    let creator: CreatorDTO
    let time: String
    let content: String
    let productID: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image
        case creator
        case time
        case content
        case productID = "product_id"
    }
}
