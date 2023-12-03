//
//  KeychainService.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation

class KeychainService {
    func save(key: String, value: String) throws {
        guard let decodeValue = value.data(using: String.Encoding.utf8) else { throw KeychainError.unexpectedPasswordData }
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecValueData as String: decodeValue
                                    ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
    }
}
