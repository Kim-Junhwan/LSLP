//
//  LoginResponseErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/02.
//

import Foundation

struct LoginResponseErrorHandler: ResponseErrorHandler {
    
    enum ResponseError: Int, ResponseErrorType {
        case cannotLogin = 401
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            completion(.notRetry(title: "로그인 실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
        }
        
        var errorDescription: String? {
            switch self {
            case .cannotLogin:
                return "존재하지 않는 회원이거나, 아이디 혹은 비밀번호가 일치하지 않습니다."
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        if let response = AuthorizationCommonErrorHandler().mappingStatusCode(statusCode: statusCode) {
            return response
        }
        return ResponseError(rawValue: statusCode)
    }
}
