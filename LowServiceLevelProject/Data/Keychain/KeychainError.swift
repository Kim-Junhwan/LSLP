//
//  KeychainError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/03.
//

import Foundation

enum KeychainError: Error {
    case noAccessToken
    case noRefreshToken
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
