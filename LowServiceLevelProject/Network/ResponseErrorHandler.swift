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

protocol ResponseError: Error, LocalizedError {
    func retry(endpoint: Requestable, completion: @escaping(RetryResult) -> Void)
}

protocol ResponseErrorHandler {
    associatedtype ResponseErrorType: ResponseError
    
    func mappingStatusCode(statusCode: Int) -> ResponseError?
}
