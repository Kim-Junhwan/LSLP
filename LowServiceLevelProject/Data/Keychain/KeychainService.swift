//
//  KeychainService.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation

final class KeychainService {
    
    static let shared = KeychainService()
    
    private init() {}
    
    func save(key: String, value: String) throws {
        guard let decodeValue = value.data(using: String.Encoding.utf8) else { throw KeychainError.unexpectedPasswordData }
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecValueData as String: decodeValue
                                    ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    func search(key: String, errorKind: KeychainError) throws -> String {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: true
                                    ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw errorKind }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String: Any],
              let originData = existingItem[kSecValueData as String] as? Data,
              let data = String(data: originData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedPasswordData
        }
        return data
    }
    
    func update(key: String, value: String, errorKind: KeychainError) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        let convertValue = value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecValueData as String: convertValue]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw errorKind}
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    func delete(key: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
