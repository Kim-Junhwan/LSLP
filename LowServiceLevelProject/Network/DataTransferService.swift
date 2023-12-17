//
//  DataTransferService.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum DataTransferServiceError: Error {
    case parsing(error: Error)
    case noData
    case networkError(error: NetworkServiceError)
    case unknownStatusCode(statusCode: Int)
}

final class DataTransferService<DefaultErrorHandler: ResponseErrorHandler> {
    private let networkService: NetworkService
    private let defaultResponseErrorHandler: DefaultErrorHandler
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService, defaultResponseHandler: DefaultErrorHandler) {
        self.networkService = networkService
        self.defaultResponseErrorHandler = defaultResponseHandler
    }
    
    func request<T: Decodable,U: Networable>(endpoint: U, endpointResponseHandler: (some ResponseErrorHandler)?, completion: @escaping (Result<U.responseType, Error>) -> Void) where T == U.responseType{
        let responseResultClosure: (RetryResult) -> Void = { result in
            switch result {
            case .notRetry(let error):
                completion(.failure(error))
            case .retry(let end, let maxCount):
                self.request(count: 0, maxCount: maxCount, endpoint: end, endpointResponseHandler: endpointResponseHandler) { result in
                    completion(result)
                }
            case .notRetryNotPass:
                break
            case .retryNotPass(endpoint: let endpoint, maxCount: let maxCount):
                break
            }
        }
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<U.responseType, Error> = self.decode(data: data)
                completion(fetchData)
            case .failure(let error):
                switch error {
                case .responseError(statusCode: let statusCode, data: _):
                    if let defaultStatus = self.defaultResponseErrorHandler.mappingStatusCode(statusCode: statusCode) {
                        defaultStatus.retry(endpoint: endpoint, completion: responseResultClosure)
                        return
                    } else {
                        endpointResponseHandler?.mappingStatusCode(statusCode: statusCode)?.retry(endpoint: endpoint, completion: responseResultClosure)
                    }
                case .networkError(let netwokError):
                    completion(.failure(netwokError))
                case .url:
                    completion(.failure(error))
                }
            }
        }
    }
    
    func request<T: Decodable,U: Networable>(endpoint: U,completion: @escaping (Result<U.responseType, Error>) -> Void) where T == U.responseType{
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<U.responseType, Error> = self.decode(data: data)
                completion(fetchData)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func request<T: Decodable>(count: Int, maxCount: Int,endpoint: Requestable, endpointResponseHandler: (some ResponseErrorHandler)?,  completion: @escaping (Result<T, Error>) -> Void){
        
        let responseClosure: (RetryResult) -> Void = { retryResult in
            switch retryResult {
            case .notRetry(let error):
                completion(.failure(error))
            case .retry(let endpoint, let maxCount):
                self.request(count: count+1, maxCount: maxCount, endpoint: endpoint, endpointResponseHandler: endpointResponseHandler) { result in
                    completion(result)
                }
            case .notRetryNotPass:
                break
            case .retryNotPass(endpoint: let endpoint, maxCount: let maxCount):
                break
            }
        }
        
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let success):
                let fetchData: Result<T, Error> = self.decode(data: success)
                completion(fetchData)
            case .failure(let failure):
                switch failure {
                case .responseError(statusCode: let statusCode, data: _):
                    let responseError: ResponseErrorType?
                    if let defaultError = self.defaultResponseErrorHandler.mappingStatusCode(statusCode: statusCode) {
                        responseError = defaultError
                    } else {
                        responseError = endpointResponseHandler?.mappingStatusCode(statusCode: statusCode)
                    }
                    guard let responseError else { 
                        completion(.failure(DataTransferServiceError.unknownStatusCode(statusCode: statusCode)))
                        return
                    }
                    if count >= maxCount {
                        completion(.failure(responseError))
                        return
                    }
                    responseError.retry(endpoint: endpoint, completion: responseClosure)
                case .networkError(error: _), .url:
                    completion(.failure(failure))
                }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, Error> {
        guard let data = data else { return .failure(DataTransferServiceError.noData) }
        do {
            let decoding = try jsonDecoder.decode(T.self, from: data)
            return .success(decoding)
        } catch {
            return .failure(DataTransferServiceError.parsing(error: error))
        }
        
    }
}
