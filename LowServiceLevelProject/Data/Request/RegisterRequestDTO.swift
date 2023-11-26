//
//  RegisterRequest.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

struct RegisterRequestDTO: Encodable {
    let email: String
    let password: String
    let nick: String
    let phoneNumber: String?
    let birthDay: String?
}
