//
//  ErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

enum RetryResult {
    case notRetry(error: Error)
    case retry(endpoint: EndPoint<<#T: Decodable#>>)
}

protocol ResponseError: Error {
    func retry(endpoint: some Networable, completion: @escaping(RetryResult) -> Void)
}

protocol ResponseErrorHandler {
    associatedtype ResponseErrorType: ResponseError
    
    func mappingStatusCode(statusCode: Int) -> ResponseError?
}
