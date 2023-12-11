//
//  APIs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation


enum AuthorizationEndpoints {
    static func registerService(request: RegisterRequestDTO) -> EndPoint<EmptyResponse> {
        return EndPoint(path: "join", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
    
    static func validateEmail(request: ValidateEmailRequestDTO) -> EndPoint<EmptyResponse> {
        return EndPoint(path: "validation/email", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
    
    static func login(request: LoginRequestDTO) -> EndPoint<LoginResponse> {
        return EndPoint(path: "login", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
}

enum TokenEndpoints {
    static func refreshAccessToken() -> EndPoint<RefreshAccessTokenResponse> {
        return EndPoint(path: "refresh", method: .GET, header: ["Content-Type":"application/json", "Authorization":try! KeychainService.shared.search(key: KeychainAuthorizNameSpace.accesshToken, errorKind: .noAccessToken), "Refresh":try! KeychainService.shared.search(key: KeychainAuthorizNameSpace.refreshToken, errorKind: .noRefreshToken)])
    }
}

enum ProfileEndpoints {
    static func getMyProfile() -> EndPoint<MyProfileResponse> {
        return EndPoint(path: "profile/me", method: .GET, header: ["Authorization":try! KeychainService.shared.search(key: KeychainAuthorizNameSpace.accesshToken, errorKind: .noAccessToken)])
    }
}
