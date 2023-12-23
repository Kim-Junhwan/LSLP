//
//  AuthorizationError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/27.
//

import Foundation

struct AuthorizationCommonErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        
        case emptyRequireValue = 400
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .emptyRequireValue:
                completion(.notRetry(title: "인증 실패", errorDecoding: .localized(description: "필수값이 누락되었습니다.")))
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
    
}
