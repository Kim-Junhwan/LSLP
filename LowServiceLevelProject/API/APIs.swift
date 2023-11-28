//
//  APIs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum LSLPAPIEndpoints {
    static func registerService(request: RegisterRequestDTO) -> EndPoint<EmptyResponse, AuthorizationCommonErrorHandler> {
        return EndPoint(path: "join", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
    
    static func validateEmail(request: ValidateEmailRequestDTO) -> EndPoint<EmptyResponse, AuthorizationCommonErrorHandler> {
        return EndPoint(path: "validation/email", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
}
