//
//  UpdateProfileViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/13.
//

import Foundation
import SwiftUI

class UpdateProfileViewModel: ObservableObject {
    @Published var nick: String
    @Published var phoneNum: String?
    @Published var birthDay: String?
    @Published var profileImage: Data?
    @Published var currentError: Error?
    
    init(nick: String, phoneNum: String? = nil, birthDay: String? = nil, profileImage: Data? = nil) {
        self.nick = nick
        self.phoneNum = phoneNum
        self.birthDay = birthDay
        self.profileImage = profileImage
    }
}
