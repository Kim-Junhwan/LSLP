//
//  ProfileRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct EditProfileQuery {
    let nick: String?
    let phoneNum: String?
    let birthDay: String?
    let profileImage: Data?
}

protocol ProfileRepository {
    func getMyProfile(completion: @escaping (Result<MyProfile, Error>)-> Void)
    func editMyProfile(query: EditProfileQuery ,completion: @escaping (Result<MyProfile, Error>)-> Void)
}
