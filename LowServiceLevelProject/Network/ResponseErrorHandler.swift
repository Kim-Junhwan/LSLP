//
//  ErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

enum RetryResult {
    case notRetry(error: Error)
    case retry
}

protocol ResponseErrorHandler {
    associatedtype ResponseError: Error
    func mappingStatusCode(statusCode: Int) -> ResponseError?
    func retry(reseponseError: ResponseError ,completion: @escaping(RetryResult) -> Void)
}

extension ResponseErrorHandler {
    func errorHandling(endPoint: Requestable, networkService: NetworkService, completion: @escaping (Result<Data, Error>) -> Void) {}
}
