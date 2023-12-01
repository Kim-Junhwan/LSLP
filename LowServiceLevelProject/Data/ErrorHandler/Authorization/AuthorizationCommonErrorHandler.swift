//
//  AuthorizationError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/27.
//

import Foundation

struct AuthorizationCommonErrorHandler: ResponseErrorHandler {
    
    enum ResponseErrorType: Int, ResponseError {
        
        case emptyRequireValue = 400
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .emptyRequireValue:
                completion(.notRetry(error: self))
            }
        }
        
        var errorDescription: String? {
            switch self {
            case .emptyRequireValue:
                return "필수값이 입력되지 않았습니다."
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseError? {
        return ResponseErrorType(rawValue: statusCode)
    }
    
}
