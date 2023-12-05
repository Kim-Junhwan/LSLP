//
//  RegisterViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/05.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nick: String = ""
    @Published var phone: String = ""
    @Published var birthDay: Date = Date()
    
    @Published var isLoading: Bool = false
    @Published var currentError: Error?
    @Published var registerSuccess: Bool = false
    @Published var validEmail: Bool = false
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.registerConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    func regist() {
        repository.register(request: .init(email: email, password: password, nick: nick, phoneNumber: phone, birthDay: birthDay.description)) { [weak self] result in
            switch result {
            case .success(_):
                self?.registerSuccess = true
            case .failure(let failure):
                self?.currentError = failure
            }
        }
    }
    
    func validateEmail() {
        repository.validateEmail(request: .init(email: email)) { [weak self] result in
            switch result {
            case .success(_):
                self?.validEmail = true
            case .failure(let failure):
                self?.currentError = failure
            }
        }
    }
}
