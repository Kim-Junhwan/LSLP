//
//  LoginFlowUseCase.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/12.
//

import Foundation

protocol LoginFlowUseCase {
    func login(email: String, password: String, completion: @escaping (NetworkError?) -> Void)
    func logout() throws
}

final class DefaultLoginFlowUseCase {
    let loginRepository: AuthorizationRepository
    let tokenRepository: TokenRepository
    
    init(loginRepository: AuthorizationRepository, tokenRepository: TokenRepository) {
        self.loginRepository = loginRepository
        self.tokenRepository = tokenRepository
    }
}

extension DefaultLoginFlowUseCase: LoginFlowUseCase {
    
    func login(email: String, password: String, completion: @escaping (NetworkError?) -> Void) {
        loginRepository.login(request: .init(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let success):
                do {
                    try self?.tokenRepository.saveToken(tokenCase: .accessToken, value: success.accessToken)
                    try self?.tokenRepository.saveToken(tokenCase: .refreshToken, value: success.refreshToken)
                    completion(nil)
                } catch {
                    completion(.init(title: "", description: "", originError: error))
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func logout() throws {
        try tokenRepository.deleteToken(tokenCase: .accessToken)
        try tokenRepository.deleteToken(tokenCase: .refreshToken)
    }
}
