//
//  MyProfileResponse.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct MyProfileResponse: Decodable {
    let posts: [String]
    let followers: [FriendResponse]
    let following: [FriendResponse]
    let _id: String
    let email: String
    let nick: String
    let phoneNum: String
    let birthDay: String
    let profile: String?
    
    func toDomain() -> MyProfile {
        return .init(postsId: posts, followers: followers.map { $0.toDomain() }, following: following.map { $0.toDomain() }, id: _id, email: email, nick: nick, phoneNumber: phoneNum, birthDay: birthDay, profileImagePath: profile)
    }
}

struct FriendResponse: Decodable {
    let _id: String
    let nick: String
    let profile: String
    
    func toDomain() -> Friend {
        return .init(id: _id, nick: nick, profileImagePath: profile)
    }
}
