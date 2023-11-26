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
    case networkError(error: NetworkError)
}

final class DataTransferService {
    private let networkService: NetworkService
    private let defaultResponseErrorHandler: ResponseErrorHandler?
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService, defaultResponseHandler: ResponseErrorHandler? = nil) {
        self.networkService = networkService
        self.defaultResponseErrorHandler = defaultResponseHandler
    }
    
    func request<T: Decodable,U: Networable, R: ResponseErrorHandler>(endpoint: U , errorhandler: R, completion: @escaping (Result<U.responseType, Error>) -> Void) where T == U.responseType{
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<U.responseType, Error> = self.decode(data: data)
                completion(fetchData)
            case .failure(let error):
                switch error {
                case .responseError(statusCode: let statusCode, data: _):
                    if let responseHandler = self.defaultResponseErrorHandler {
                        responseHandler.mappingStatusCode(statusCode: statusCode)?.errorHandling(endPoint: endpoint, networkService: self.networkService, completion: { result in
                            
                        })
                    }
                    errorhandler.mappingStatusCode(statusCode: statusCode)?.errorHandling(endPoint: endpoint, networkService: self.networkService, completion: { result in
                        
                    })
                case .networkError(error: _), .url:
                    completion(.failure(error))
                }
            }
        }
    }
    
    func request<T: Decodable,U: Networable>(endpoint: U, completion: @escaping (Result<U.responseType, Error>) -> Void) where T == U.responseType{
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
