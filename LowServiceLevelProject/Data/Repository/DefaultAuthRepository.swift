//
//  DefaultAuthRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

final class DefaultAuthRepository {
    private let dataTransferService: DataTransferService<CommonResponseErrorHandler>
    
    init(dataTransferService: DataTransferService<CommonResponseErrorHandler>) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultAuthRepository: AuthorizationRepository {
    
    func register(request: RegisterRequestDTO, completion: @escaping (Result<EmptyResponse, Error>) -> Void ) {
        let request = RegisterRequestDTO(email: request.email, password: request.password, nick: request.nick, phoneNumber: request.phoneNumber, birthDay: request.birthDay?.description)
        dataTransferService.request(endpoint: LSLPAPIEndpoints.registerService(request: request), endpointResponseHandler: RegisterResponseErrorHandler()) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func validateEmail(request: ValidateEmailRequest, completion: @escaping (Result<EmptyResponse, Error>) -> Void) {
        let endpoint = ValidateEmailRequestDTO(email: request.email)
        dataTransferService.request(endpoint: LSLPAPIEndpoints.validateEmail(request: endpoint), endpointResponseHandler: ValidateEmailResponseErrorHandler()) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let endpoint = LoginRequestDTO(email: request.email, password: request.password)
        dataTransferService.request(endpoint: LSLPAPIEndpoints.login(request: endpoint), endpointResponseHandler: LoginResponseErrorHandler()) { result in
            switch result {
            case .success(let success):
                do {
                    try KeychainService.shared.save(key: KeychainAuthorizNameSpace.refreshToken, value: success.refreshToken)
                    try KeychainService.shared.save(key: KeychainAuthorizNameSpace.accesshToken, value: success.token)
                    completion(.success(success))
                } catch {
                    completion(.failure(KeychainError.alrealyValue))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
