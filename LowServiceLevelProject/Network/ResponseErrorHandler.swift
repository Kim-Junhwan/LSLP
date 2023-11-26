//
//  ErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/21.
//

import Foundation

protocol ResponseErrorHandler {
    func errorHandling(endPoint: Requestable, networkService: NetworkService, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func mappingStatusCode(statusCode: Int) -> Self?
    
    func retry(completion: @escaping(Result<Data, NetworkError>) -> Void)
}
