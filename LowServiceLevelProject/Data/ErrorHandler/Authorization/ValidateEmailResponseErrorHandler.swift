//
//  ValidateEmailResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/29.
//

import Foundation

struct ValidateEmailResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        
        case notValidEmail = 409
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(error: self))
        }
        
        var errorDescription: String? {
            switch self {
            case .notValidEmail:
                return "유효하지 않는 이메일입니다."
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
    
}
