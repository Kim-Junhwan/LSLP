//
//  TokenErrorHandler.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

struct TokenErrorHandler: ResponseErrorHandler {
    enum ResponseError: Int, ResponseErrorType {
        case unknownAccessToken = 401
        case expirationAccessToken = 419
        case forbidden = 403
        
        func retry(endpoint: Requestable , completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .unknownAccessToken, .forbidden:
                completion(.notRetry(error: self))
            case .expirationAccessToken:
                let refreshEndpoint = TokenEndpoints.refreshAccessToken()
                let dataTransferService = DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler())
                dataTransferService.request(endpoint: refreshEndpoint, endpointResponseHandler: AccessTokenRefreshErrorHandler()) { result in
                    switch result {
                    case .success(let refreshToken):
                        var copyReq = endpoint
                        copyReq.headerParameter["Authorization"] = refreshToken.token
                        completion(.retry(endpoint: copyReq, maxCount: 1))
                    case .failure(let failure):
                        completion(.notRetry(error: failure))
                    }
                }
                
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
}
