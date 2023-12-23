//
//  RegisterResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/01.
//

import Foundation

struct RegisterResponseErrorHandler: ResponseErrorHandler {
    enum ResponseError: Int, ResponseErrorType {
        
        case alreadyJoinMember = 409
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(title: "회원가입 실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
    
}
