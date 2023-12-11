//
//  RefreshTokenErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/08.
//

import Foundation

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
        
        var errorDescription: String? {
            switch self {
            case .accessTokenIsValid:
                return "액세스 토큰이 옳바르지 않습니다."
            case .expirationRefreshToken:
                return "리프레시 토큰이 만료되었습니다."
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
