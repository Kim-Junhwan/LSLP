//
//  UpdateProfileViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/13.
//

import Foundation
import SwiftUI

class UpdateProfileViewModel: ObservableObject {
    
    private let originNick: String
    private let originPhoneNum: String?
    private let originBirthDay: String?
    
    @Published var nick: String
    @Published var phoneNum: String?
    @Published var birthDay: String?
    @Published var currentError: Error?
    
    @Published var profileImage: Data?
    
    let repository: ProfileRepository
    
    var profileImageSize: Float {
        return Float(profileImage?.count ?? 0) / 1024 / 1024
    }
    
    var canUpdateProfile: Bool {
        return (profileImageSize <= 1.0 || profileImageSize == 0.0) && (nick != originNick) && (phoneNum != originPhoneNum) && (birthDay != originBirthDay) && !nick.isEmpty
    }
    
    init(nick: String, phoneNum: String? = nil, birthDay: String? = nil, profileImage: Data? = nil, profileRepository: ProfileRepository) {
        self.nick = nick
        self.originNick = nick
        self.phoneNum = phoneNum
        self.originPhoneNum = phoneNum
        self.birthDay = birthDay
        self.originBirthDay = birthDay
        self.profileImage = profileImage
        self.repository = profileRepository
    }
    
    func editProfile() {
        repository.editMyProfile(query: .init(nick: nick, phoneNum: phoneNum, birthDay: birthDay, profileImage: profileImage)) { result in
            
        }
    }
}
