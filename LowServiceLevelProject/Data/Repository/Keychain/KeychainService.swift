//
//  KeychainService.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation

final class DefaultTokenRepository: TokenRepository {
    
    func saveToken(tokenCase: TokenCase, value: String) throws {
        try Self.saveTokenAtKeyChain(tokenCase: tokenCase, value: value)
    }
    
    func readToken(tokenCase: TokenCase) throws -> String {
        try Self.readTokenAtKeyChain(tokenCase: tokenCase)
    }
    
    func deleteToken(tokenCase: TokenCase) throws {
        try Self.deleteTokenAtKeyChain(tokenCase: tokenCase)
    }
    
    static func saveTokenAtKeyChain(tokenCase: TokenCase, value: String) throws {
        guard let decodeValue = value.data(using: String.Encoding.utf8) else { throw KeychainError.unexpectedPasswordData }
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: tokenCase.tokenIdentifier,
                                    kSecValueData as String: decodeValue
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            if status == errSecDuplicateItem {
                try updateTokenValueAtKeyChain(tokenCase: tokenCase, value: value)
            } else {
                throw KeychainError.unhandledError(status: status)
            }
        }
    }
    
    static func readTokenAtKeyChain(tokenCase: TokenCase) throws -> String {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: tokenCase.tokenIdentifier,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true
                                    ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String: Any],
              let originData = existingItem[kSecValueData as String] as? Data,
              let data = String(data: originData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedPasswordData
        }
        return data
    }
    
    static func deleteTokenAtKeyChain(tokenCase: TokenCase) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: tokenCase.tokenIdentifier]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    static private func updateTokenValueAtKeyChain(tokenCase: TokenCase, value: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: tokenCase.tokenIdentifier]
        let convertValue = value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecValueData as String: convertValue]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
}
