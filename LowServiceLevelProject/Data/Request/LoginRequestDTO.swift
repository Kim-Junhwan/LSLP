//
//  LoginRequestDTO.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/02.
//

import Foundation

struct LoginRequestDTO: Encodable {
    let email: String
    let password: String
}
