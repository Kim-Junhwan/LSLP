//
//  DefaultAuthRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

final class DefaultAuthRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultAuthRepository: AuthorizationRepository {
    
    func register(request: RegisterRequest) {
        let request = RegisterRequest(email: request.email, password: request.password, nick: request.nick, phoneNumber: request.phoneNumber, birthDay: request.birthDay?.description)
        dataTransferService.request(endpoint: LSLPAPIEndpoints.registerService(request: request)) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                if let error = failure as? NetworkError {
                    print("networkError \(error)")
                }
                print(failure.localizedDescription)
            }
        }
    }
    
    func validateEmail(request: ValidateEmailRequest) {
        <#code#>
    }
    
    func login(request: LoginRequest) {
        <#code#>
    }
}
