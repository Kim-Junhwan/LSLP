//
//  UserProfile.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct MyProfile {
    let postsId: [String]
    let followers: [Friend]
    let following: [Friend]
    let id: String
    let email: String
    let nick: String
    let phoneNumber: String?
    let birthDay: String?
    let profileImagePath: String?
}

struct Friend {
    let id: String
    let nick: String
    let profileImagePath: String
}
