//
//  ErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

enum RetryResult {
    case notRetry(title: String? = nil, errorDecoding: ErrorDecoding)
    case retry(endpoint: Requestable, title: String? = nil, errorDecoding: ErrorDecoding, maxCount: Int = 1)
    case notRetryNotPass
    case retryNotPass(endpoint: Requestable, maxCount: Int = 1)
}

enum ErrorDecoding {
    case localized(description: String)
    case decoding(decoding: DecodingErrorType.Type)
}

protocol DecodingErrorType: Decodable {
    func description() -> String
}

protocol ResponseErrorType: Error {
    func retry(endpoint: Requestable, completion: @escaping(RetryResult) -> Void)
}

protocol ResponseErrorHandler {
    associatedtype ResponseError: ResponseErrorType
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType?
}
