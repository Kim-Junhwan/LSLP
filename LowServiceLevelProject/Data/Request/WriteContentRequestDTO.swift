//
//  WriteContentRequestDTO.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/31.
//

import Foundation

struct WriteContentRequestDTO: Encodable {
    let content: String
    let product_id: String
}
