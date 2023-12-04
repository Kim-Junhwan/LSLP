//
//  ErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

enum RetryResult {
    case notRetry(error: Error)
    case retry(endpoint: Requestable, maxCount: Int)
}

protocol ResponseErrorType: LocalizedError {
    func retry(endpoint: Requestable, completion: @escaping(RetryResult) -> Void)
}

protocol ResponseErrorHandler {
    associatedtype ResponseError: ResponseErrorType
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType?
}
