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
        return EndPoint(path: "refresh", method: .GET, header: ["Content-Type":"application/json", "Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken), "Refresh":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .refreshToken)])
    }
}

enum ProfileEndpoints {
    static func getMyProfile() -> EndPoint<MyProfileResponse> {
        return EndPoint(path: "profile/me", method: .GET, header: ["Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken)])
    }
    
    static func updateMyProfile(request: UpdateProfileRequestDTO) -> EndPoint<MyProfileResponse> {
        return EndPoint(path: "profile/me", method: .PUT, header: ["Content-Type":"multipart/form-data", "Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken)], bodyParameter: request)
    }
}
