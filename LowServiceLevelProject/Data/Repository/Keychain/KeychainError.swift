//
//  KeychainError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/03.
//

import Foundation

enum KeychainError: Error {
    case noToken
    case unexpectedPasswordData
    case alrealyValue
    case unhandledError(status: OSStatus)
}
