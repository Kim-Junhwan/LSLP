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
    @Published var isLoading: Bool = false
    @Published var refreshTokenExpireAlert: Bool = false
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    init() {
        let _ = NotificationCenter.default.publisher(for: .init("expirationRefreshToken"))
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
            self?.refreshTokenExpireAlert = true
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        repository.login(request: .init(email: email, password: "\(password)")) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.isLoggedIn = true
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.isLoading = false
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
