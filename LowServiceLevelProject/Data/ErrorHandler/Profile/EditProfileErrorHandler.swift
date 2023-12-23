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
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(title: "프로필 수정 실패", errorDecoding: .localized(description: "프로필 수정에 실패했습니다.")))
        }
        
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = TokenErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
}
