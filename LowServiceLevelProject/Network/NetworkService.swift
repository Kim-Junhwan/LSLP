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
    
    var title: String {
        return "네트워크 에러"
    }
}

protocol NetworkService {
    func request(endPoint: Requestable ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void)
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
    
}
