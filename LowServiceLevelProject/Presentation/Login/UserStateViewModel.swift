//
//  UserStateViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/05.
//

import Foundation

@MainActor
class UserStateViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentError: Error?
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    func signIn(email: String, password: String) {
        repository.login(request: .init(email: email, password: "\(password)")) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.isLoggedIn = true
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.currentError = failure
                    self?.isLoggedIn = false
                }
            }
        }
    }
    
    func signOut() {
        do {
            try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.accesshToken)
            try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.refreshToken)
            isLoggedIn = false
        } catch {
            currentError = error
        }
    }
}
