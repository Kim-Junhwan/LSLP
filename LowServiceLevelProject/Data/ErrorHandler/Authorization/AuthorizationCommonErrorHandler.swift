//
//  AuthorizationError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/27.
//

import Foundation

enum AuthorizationCommonErrorHandler: Int, ResponseErrorHandler {
    
    case missRequireValue = 400
    
    func mappingStatusCode(statusCode: Int) -> AuthorizationCommonErrorHandler? {
        return .init(rawValue: statusCode)
    }
    
    var errorDescription: String? {
        switch self {
        case .missRequireValue:
            return "필수값이 누락되었습니다."
        }
    }
}
