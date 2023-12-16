//
//  UpdateProfileRequestDTO.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/14.
//

import Foundation

struct UpdateProfileRequestDTO: Encodable {
    let nick: String?
    let phoneNum: String?
    let birthDay: String?
}
