//
//  APIs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum LSLPAPIEndpoints {
    static func registerService(request: RegisterRequest) -> EndPoint<RegisterResponse> {
        return EndPoint(path: "join", method: .POST, header: ["Content-Type":"application/json"], bodyParameter: request)
    }
}
