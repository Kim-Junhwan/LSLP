//
//  CommonResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/23.
//

import Foundation

struct CommonResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseErrorType: Int, ResponseError {
        case secretKeyError = 420
        case tooMuchCall = 429
        case pathError = 444
        case serverError = 500
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(error: self))
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseError? {
        return ResponseErrorType(rawValue: statusCode)
    }
}
