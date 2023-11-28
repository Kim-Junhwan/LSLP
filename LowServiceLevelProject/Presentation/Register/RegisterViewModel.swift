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
    @Published var isLoading: Bool = false
    var errorDescription: String = ""
    
    var emailEmpty: Bool {
        return email.isEmpty
    }
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.registerConfig)))
    
//    init(repository: AuthorizationRepository) {
//        self.repository = repository
//    }
    
    func register(completion: @escaping (Error?)-> Void) {
        changeLoadingValue(true)
        repository.register(request: .init(email: email, password: password, nick: nick, phoneNumber: phone, birthDay: birthDay.description)) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                self.errorDescription = failure.localizedDescription
                completion(failure)
            }
            self.changeLoadingValue(false)
        }
    }
    
    func validateEmail(completion: @escaping (Error?)-> Void) {
        changeLoadingValue(true)
        repository.validateEmail(request: .init(email: email)) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                self.errorDescription = failure.localizedDescription
                completion(failure)
            }
            self.changeLoadingValue(false)
        }
    }
    
    private func changeLoadingValue(_ bool: Bool) {
        DispatchQueue.main.async {
            self.isLoading = bool
        }
    }
}
