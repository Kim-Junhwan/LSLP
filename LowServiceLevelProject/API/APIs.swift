//
//  APIs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum LSLPAPIEndpoints {
    case register(_ request: RegisterRequest)
    
    var baseURL: URL {
        guard let url = URL(string: APIKey.baseURL) else { fatalError("failed make baseurl") }
        return url
    }
    
    var baseHeader: [String: String] {
        var header: [String: String] = [:]
        header["SesacKey"] = ""
        switch self {
        case .register(_):
            header["Content-Type"] = "application/json"
        }
        
        return header
    }
    
    var path: String {
        switch self {
        case .register(_):
            return "/join"
        }
    }
    
    var method: HTTPMethodType {
        switch self {
        case .register(_):
            return .POST
        }
    }
    
    func makeEndpoint() -> any Networable {
        switch self {
        case .register(let registerInfo):
            return EndPoint<RegisterResponse>(path: path, method: method, bodyParameter: registerInfo)
        }
    }
}
