//
//  TokenErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct TokenErrorHandler: ResponseErrorHandler {
    enum ResponseError: Int, ResponseErrorType {
        case unknownAccessToken = 401
        case expirationAccessToken = 419
        case forbidden = 403
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .unknownAccessToken, .forbidden:
                completion(.notRetry(error: self))
            case .expirationAccessToken:
                completion(.notRetry(error: self))
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
}
