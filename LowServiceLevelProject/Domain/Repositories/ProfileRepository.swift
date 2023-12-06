//
//  ProfileRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

protocol ProfileRepository {
    func getMyProfile(completion: @escaping (Result<MyProfile, Error>)-> Void)
    func editMyProfile(completion: @escaping (Result<MyProfile, Error>)-> Void)
    
}
