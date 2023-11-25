//
//  RegisterViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nick: String = ""
    @Published var phone: String = ""
    @Published var birthDay: Date = Date()
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.registerConfig)))
    
//    init(repository: AuthorizationRepository) {
//        self.repository = repository
//    }
    
    func register() {
        repository.register(registerInfo: .init(email: email, password: password, nickName: nick, phoneNumber: phone, birthDay: birthDay))
    }
}
