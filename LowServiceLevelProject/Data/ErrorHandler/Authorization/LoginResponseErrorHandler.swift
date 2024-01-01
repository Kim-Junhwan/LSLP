//
//  LoginResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/02.
//

import Foundation

struct LoginResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        case cannotLogin = 401
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(title: "로그인 실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
}
