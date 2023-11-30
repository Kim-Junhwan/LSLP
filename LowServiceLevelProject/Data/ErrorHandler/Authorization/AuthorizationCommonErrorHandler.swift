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
        
        func retry(endpoint: some Networable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .emptyRequireValue:
                completion(.notRetry(error: self))
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseError? {
        return ResponseErrorType(rawValue: statusCode)
    }
   
}
