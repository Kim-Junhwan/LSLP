//
//  RefreshTokenErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/08.
//

import Foundation

struct ErrorDesctiption: DecodingErrorType {
    
    let message: String
    
    func description() -> String {
        return message
    }
}

struct AccessTokenRefreshErrorHandler: ResponseErrorHandler {
    enum ResponseError: Int, ResponseErrorType {
        case accessTokenIsValid = 409
        case expirationRefreshToken = 418
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .accessTokenIsValid:
                completion(.notRetryNotPass)
            case .expirationRefreshToken:
                NotificationCenter.default.post(name: .init("expirationRefreshToken"), object: nil)
                completion(.notRetryNotPass)
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = TokenErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
}
