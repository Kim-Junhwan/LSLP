//
//  RegisterResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/01.
//

import Foundation

struct RegisterResponseErrorHandler: ResponseErrorHandler {
    enum ResponseErrorType: Int, ResponseError {
        
        case alreadyJoinMember = 409
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(error: self))
        }
        
        var errorDescription: String? {
            switch self {
            case .alreadyJoinMember:
                return "이미 가입된 회원입니다."
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseError? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseErrorType(rawValue: statusCode)
    }
    
}
