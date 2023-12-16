//
//  NetworkService.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum NetworkServiceError: Error {
    case responseError(statusCode: Int, data: Data?)
    case networkError(error: Error)
    case url
}

protocol NetworkService {
    func request(endPoint: Requestable ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void)
    func upload(endPoint: Requestable, data: Data ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void)
}

final class DefaultNetworkService {
    
    private let config: NetworkConfiguration
    
    init(config: NetworkConfiguration) {
        self.config = config
    }
}

extension DefaultNetworkService: NetworkService {
    
    func request(endPoint: Requestable ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void) {
        do {
            let request = try endPoint.makeURLRequest(networkConfig: config)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error: error)))
                } else {
                    if let response = response as? HTTPURLResponse {
                        if (200..<300) ~= response.statusCode {
                            completion(.success(data))
                        } else {
                            completion(.failure(.responseError(statusCode: response.statusCode, data: data)))
                        }
                    }
                    
                }
            }.resume()
        } catch {
            completion(.failure(.url))
        }
    }
    
    func upload(endPoint: Requestable, data: Data ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void) {
        do {
            var request = try endPoint.makeURLRequest(networkConfig: config)
            request.httpBody = 
            URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error: error)))
                } else {
                    if let response = response as? HTTPURLResponse {
                        if (200..<300) ~= response.statusCode {
                            completion(.success(data))
                        } else {
                            completion(.failure(.responseError(statusCode: response.statusCode, data: data)))
                        }
                    }
                    
                }
            }.resume()
        } catch {
            completion(.failure(.url))
        }
        
    }
    
}
