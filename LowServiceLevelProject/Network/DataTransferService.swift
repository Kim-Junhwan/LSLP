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
    
    var title: String {
        return "에러"
    }
}

final class DataTransferService<DefaultErrorHandler: ResponseErrorHandler> {
    private let networkService: NetworkService
    private let defaultResponseErrorHandler: DefaultErrorHandler
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService, defaultResponseHandler: DefaultErrorHandler) {
        self.networkService = networkService
        self.defaultResponseErrorHandler = defaultResponseHandler
    }
    
    private func handleStatusCode<T: Decodable>(endpoint: Requestable,
                                                endpointResponseHandler: (some ResponseErrorHandler)?,
                                                statusCode: Int,
                                                data: Data,
                                                count: Int,
                                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        print(#function)
        var responseError: ResponseErrorType?
        if let defaultStatus = defaultResponseErrorHandler.mappingStatusCode(statusCode: statusCode) {
            responseError = defaultStatus
        } else if let endpointStatus = endpointResponseHandler?.mappingStatusCode(statusCode: statusCode) {
            responseError = endpointStatus
        }
        guard let responseError else {
            completion(.failure(.init(title: "", description: "", originError: DataTransferServiceError.unknownStatusCode(statusCode: statusCode))))
            return
        }
        responseError.retry(endpoint: endpoint, completion: { result in
            switch result {
            case .notRetry(title: let title, errorDecoding: let errorDecoding):
                switch errorDecoding {
                case .localized(description: let description):
                    completion(.failure(.init(title: title, description: description, originError: responseError)))
                case .decoding(decoding: let decoding):
                    let decodeDescription = try? self.jsonDecoder.decode(decoding, from: data)
                    completion(.failure(.init(title: title, description: decodeDescription?.description() ?? "", originError: responseError)))
                }
            case .retry(let endpoint, let title, let errorDecoding, let maxCount):
                if count >= maxCount {
                    switch errorDecoding {
                    case .localized(description: let description):
                        completion(.failure(.init(title: title, description: description, originError: responseError)))
                    case .decoding(decoding: let decoding):
                        let decodeDescription = try? self.jsonDecoder.decode(decoding, from: data)
                        completion(.failure(.init(title: title, description: decodeDescription?.description() ?? "", originError: responseError)))
                    }
                    return
                }
                self.request(count: count, maxCount: maxCount, endpoint: endpoint, endpointResponseHandler: endpointResponseHandler, completion: completion)
                return
            case .notRetryNotPass:
                return
            case .retryNotPass(let endpoint, let maxCount):
                if count >= maxCount {
                    return
                }
                self.request(count: count, maxCount: maxCount, endpoint: endpoint, endpointResponseHandler: endpointResponseHandler, completion: completion)
                return
            }
        })
    }
    
    func request<T: Decodable,U: Networable>(endpoint: U, endpointResponseHandler: (some ResponseErrorHandler)?, completion: @escaping (Result<U.responseType, NetworkError>) -> Void) where T == U.responseType{
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<U.responseType, NetworkError> = self.decode(data: data)
                completion(fetchData)
            case .failure(let error):
                switch error {
                case .responseError(statusCode: let statusCode, data: let data):
                    self.handleStatusCode(endpoint: endpoint, endpointResponseHandler: endpointResponseHandler, statusCode: statusCode, data: data ?? Data(), count: 0, completion: completion)
                case .networkError(let netwokError):
                    completion(.failure(.init(title: error.title, description: error.localizedDescription, originError: netwokError)))
                case .url:
                    completion(.failure(.init(title: error.title, description: error.localizedDescription, originError: error)))
                }
            }
        }
    }
    
    func request<T: Decodable,U: Networable>(endpoint: U,completion: @escaping (Result<U.responseType, NetworkError>) -> Void) where T == U.responseType{
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<U.responseType, NetworkError> = self.decode(data: data)
                completion(fetchData)
            case .failure(let error):
                completion(.failure(.init(title: error.title, description: error.localizedDescription, originError: error)))
            }
        }
    }
    
    private func request<T: Decodable>(count: Int, maxCount: Int,endpoint: Requestable, endpointResponseHandler: (some ResponseErrorHandler)?, completion: @escaping (Result<T, NetworkError>) -> Void){
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let success):
                let fetchData: Result<T, NetworkError> = self.decode(data: success)
                completion(fetchData)
            case .failure(let failure):
                switch failure {
                case .responseError(statusCode: let statusCode, data: let data):
                    self.handleStatusCode(endpoint: endpoint, endpointResponseHandler: endpointResponseHandler, statusCode: statusCode, data: data ?? Data(), count: count+1, completion: completion)
                case .networkError(let netwokError):
                    completion(.failure(.init(title: failure.title, description: failure.localizedDescription, originError: netwokError)))
                case .url:
                    completion(.failure(.init(title: failure.title, description: failure.localizedDescription, originError: failure)))
                }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, NetworkError> {
        guard let data = data else {
            let error = DataTransferServiceError.noData
            return .failure(.init(title: error.title, description: error.localizedDescription, originError: error)) }
        do {
            let decoding = try jsonDecoder.decode(T.self, from: data)
            return .success(decoding)
        } catch {
            let error = DataTransferServiceError.parsing(error: error)
            return .failure(.init(title: error.title, description: error.localizedDescription, originError: error))
        }
        
    }
}
