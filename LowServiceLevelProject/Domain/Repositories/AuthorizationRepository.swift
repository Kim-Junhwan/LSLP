//
//  UserAuthorizationRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

protocol AuthorizationRepository {
    func register(request: RegisterRequest)
    func validateEmail(request: ValidateEmailRequest)
    func login(request: LoginRequest)
}
