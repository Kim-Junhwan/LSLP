//
//  UserProfile.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import Foundation

struct UserRegisterProfile {
    var email: String
    var password: String
    var nickName: String
    var phoneNumber: String
    var bitrhDay: Date
    
    init() {
        email = ""
        password = ""
        nickName = ""
        phoneNumber = ""
        bitrhDay = Date()
    }
}
