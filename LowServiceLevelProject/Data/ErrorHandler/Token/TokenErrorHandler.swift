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
        
        func retry(endpoint: Requestable, completion: @escaping (RetryResult) -> Void) {
            switch self {
            case .unknownAccessToken:
                completion(.notRetry(title: "에러", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
            case .forbidden:
                completion(.notRetry(title: "에러", errorDecoding: .localized(description: "접근 권한이 없습니다.")))
            case .expirationAccessToken:
                let refreshEndpoint = TokenEndpoints.refreshAccessToken()
                let dataTransferService = DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler())
                dataTransferService.request(endpoint: refreshEndpoint, endpointResponseHandler: AccessTokenRefreshErrorHandler()) { result in
                    switch result {
                    case .success(let refreshToken):
                        var copyReq = endpoint
                        do {
                            try DefaultTokenRepository.saveTokenAtKeyChain(tokenCase: .accessToken, value: refreshToken.token)
                            copyReq.headerParameter["Authorization"] = refreshToken.token
                            completion(.retry(endpoint: endpoint, title: "토큰 갱신 실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
                        } catch {
                            completion(.notRetry(title: "실패", errorDecoding: .localized(description: "토큰을 저장 할 수 없습니다.")))
                        }
                    case .failure(let failure):
                        completion(.notRetry(title: "실패", errorDecoding: .decoding(decoding: ErrorDesctiption.self)))
                    }
                }
                
            }
        }
    }
    
    func mappingStatusCode(statusCode: Int) -> ResponseErrorType? {
        return ResponseError(rawValue: statusCode)
    }
}
