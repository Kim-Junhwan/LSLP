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
            completion(.notRetry(title: "사용할 수 없는 이메일입니다.", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
    
}
