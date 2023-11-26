//
//  CommonResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/23.
//

import Foundation

enum CommonResponseErrorHandler: Int, ResponseErrorHandler {
    
    case secretKeyError = 420
    case tooMuchCall = 429
    case pathError = 444
    case serverError = 500
    
    func errorHandling(endPoint: Requestable, networkService: NetworkService, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        switch self {
        case .secretKeyError:
            print("secretKeyError")
        case .tooMuchCall:
            print("tooMuchCall")
        case .pathError:
            print("pathError")
        case .serverError:
            print("serverError")
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> CommonResponseErrorHandler? {
        return .init(rawValue: statusCode)
    }
    
    func retry(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
    }
    
    
}
