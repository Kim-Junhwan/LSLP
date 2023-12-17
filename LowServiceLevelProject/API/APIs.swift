//
//  APIs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation


enum AuthorizationEndpoints {
    static func registerService(request: RegisterRequestDTO) -> EndPoint<EmptyResponse> {
        return EndPoint(path: "join", method: .POST, contentType: .json, bodyParameter: request)
    }
    
    static func validateEmail(request: ValidateEmailRequestDTO) -> EndPoint<EmptyResponse> {
        return EndPoint(path: "validation/email", method: .POST, contentType: .json, bodyParameter: request)
    }
    
    static func login(request: LoginRequestDTO) -> EndPoint<LoginResponse> {
        return EndPoint(path: "login", method: .POST, contentType: .json, bodyParameter: request)
    }
}

enum TokenEndpoints {
    static func refreshAccessToken() -> EndPoint<RefreshAccessTokenResponse> {
        return EndPoint(path: "refresh", method: .GET, header: ["Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken), "Refresh":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .refreshToken)])
    }
}

enum ProfileEndpoints {
    static func getMyProfile() -> EndPoint<MyProfileResponse> {
        return EndPoint(path: "profile/me", method: .GET, header: ["Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken)])
    }
    
    static func updateMyProfile(request: UpdateProfileRequestDTO, image: Data?) -> EndPoint<MyProfileResponse> {
        var dataDict: [String:[Data]] = ["profile":[]]
        if let image {
            dataDict["profile"] = [image]
        }
        return EndPoint(path: "profile/me", method: .PUT,contentType: .multipart(identifier: UUID().uuidString, data: dataDict, uploader: ImageUploader()) , header: ["Authorization":try! DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken)], bodyParameter: request)
    }
}

enum ImageEndpoints {
}
