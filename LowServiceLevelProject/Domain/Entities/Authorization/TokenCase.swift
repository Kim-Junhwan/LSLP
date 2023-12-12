//
//  TokenCase.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/12.
//

import Foundation

enum TokenCase {
    case accessToken
    case refreshToken
    
    var tokenIdentifier: String  {
        switch self {
        case .accessToken:
            return "accessToken"
        case .refreshToken:
            return "refreshToken"
        }
    }
}
