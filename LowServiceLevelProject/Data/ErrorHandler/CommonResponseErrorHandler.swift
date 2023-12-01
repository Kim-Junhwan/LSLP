//
//  CommonResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/23.
//

import Foundation

struct CommonResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseErrorType: Int, ResponseError {
        case secretKeyError = 420
        case tooMuchCall = 429
        case pathError = 444
        case serverError = 500
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(error: self))
        }
        
        var errorDescription: String? {
            switch self {
            case .secretKeyError:
                return "옳바르지 않는 비밀키입니다."
            case .tooMuchCall:
                return "과호출되었습니다."
            case .pathError:
                return "옳바르지 않는 경로입니다."
            case .serverError:
                return "서버에 문제가 생겼습니다."
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseError? {
        return ResponseErrorType(rawValue: statusCode)
    }
}
