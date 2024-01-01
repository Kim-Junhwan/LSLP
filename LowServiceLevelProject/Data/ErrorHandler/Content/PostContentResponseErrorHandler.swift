//
//  PostContentResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/30.
//

import Foundation

struct PostContentResponseErrorHandler: ResponseErrorHandler {
    enum ResponseError: Int, ResponseErrorType {
        
        case contentWriteFail = 410
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.retry(endpoint: endpoint, title: "게시글 작성 실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self), maxCount: 2))
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
    
    
}
