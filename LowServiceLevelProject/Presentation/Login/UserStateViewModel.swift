//
//  UserStateViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/05.
//

import Foundation
import Combine

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var currentError: Error?
    @Published var isLoading: Bool = false
    @Published var refreshTokenExpireAlert: Bool = false
    
    
    let loginFlowUseCases: LoginFlowUseCase
    var pub: Cancellable?
    
    init(loginFlowUseCases: LoginFlowUseCase) {
        self.loginFlowUseCases = loginFlowUseCases
    }
    
    private func registeredRefreshToken() {
        pub = NotificationCenter.default.publisher(for: .init("expirationRefreshToken"))
            .receive(on: RunLoop.main)
            .sink { _ in
            self.refreshTokenExpireAlert = true
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        registeredRefreshToken()
        loginFlowUseCases.login(email: email, password: password) { error in
            if let error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.currentError = error
                    self.isLoggedIn = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isLoggedIn = true
                }
            }
        }
    }
    
    func signOut() {
        pub = nil
        do {
            try loginFlowUseCases.logout()
            isLoggedIn = false
        } catch {
            currentError = error
        }
    }
}
