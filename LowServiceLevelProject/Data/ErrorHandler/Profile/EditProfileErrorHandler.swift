//
//  EditProfileErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct EditProfileErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        case invalidRequest = 400
        
        var errorDescription: String? {
            switch self {
            case .invalidRequest:
                "알맞지 않는 파일 형식입니다"
            }
        }
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(error: self))
        }
    }
    
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = TokenErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
}
