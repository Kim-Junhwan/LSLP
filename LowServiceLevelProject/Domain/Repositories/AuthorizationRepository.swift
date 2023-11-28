//
//  UserAuthorizationRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

protocol AuthorizationRepository {
    func register(request: RegisterRequestDTO, completion: @escaping(Result<EmptyResponse,Error>) -> Void)
    func validateEmail(request: ValidateEmailRequest, completion: @escaping(Result<EmptyResponse,Error>) -> Void)
    func login(request: LoginRequest)
}
