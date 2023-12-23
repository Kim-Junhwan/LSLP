//
//  CommonResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/23.
//

import Foundation

struct CommonResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        case secretKeyError = 420
        case tooMuchCall = 429
        case pathError = 444
        case serverError = 500
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .secretKeyError:
                completion(.notRetry(title: "에러", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
            case .tooMuchCall:
                completion(.notRetry(title: "에러", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
            case .pathError:
                completion(.notRetry(title: "에러", errorDecoding: .localized(description: "옳바르지 않는 경로입니다.")))
            case .serverError:
                completion(.notRetry(title: "서버 에러", errorDecoding: .localized(description: "서버에 문제가 생겼습니다. 잠시 후 다시 시도해주십시오")))
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
}
