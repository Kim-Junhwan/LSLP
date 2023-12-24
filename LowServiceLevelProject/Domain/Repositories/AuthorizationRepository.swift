//
//  UserAuthorizationRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

protocol AuthorizationRepository {
    func register(request: RegisterRequestDTO, completion: @escaping(Result<EmptyResponse,NetworkError>) -> Void)
    func validateEmail(request: ValidateEmailRequest, completion: @escaping(Result<EmptyResponse,NetworkError>) -> Void)
    func login(request: LoginRequest, completion: @escaping (Result<LoginSuccessResponse, NetworkError>) -> Void)
}

protocol TokenRepository {
     func saveToken(tokenCase: TokenCase, value: String) throws
     func readToken(tokenCase: TokenCase) throws -> String
     func deleteToken(tokenCase: TokenCase) throws
}
