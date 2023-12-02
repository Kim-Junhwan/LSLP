//
//  LoginResponse.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/02.
//

import Foundation

struct LoginResponse: Decodable {
    let _id: String
    let token: String
    let refreshToken: String
}
