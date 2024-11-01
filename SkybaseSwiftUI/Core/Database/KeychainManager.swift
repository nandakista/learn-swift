//
//  KeychainManager.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 01/11/24.
//

import Foundation
import Security


enum KeychainError: Error {
    case unknown(OSStatus)
}

final class KeychainManager {
    private let tag = "AuthManager::=>"
    
    static let shared = KeychainManager()
    private init() {}
    
    
    let tokenKey: String = "token"

    /// Saving auth token to secure local storage (Keychain) using encrypted class kSecClassGenericPassword
    /// Will throw [KeychainError.unknown] when failed to save the token
    ///
    /// @param key Key is custom key when you don't need use default value [tokenKey].
    /// Or if you need to save refreshToken you can just passing the different one (ex: "refreshToken")
    /// Basically this is just save the String value with the given key
    ///
    /// @param token The token parameters is the actual token data
    func saveToken(forKey key: String? = nil, _ token: String) throws {
        if let data = token.data(using: .utf8) {
            var query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key ?? tokenKey,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            if let bundleId = Bundle.main.bundleIdentifier {
                query[kSecAttrService as String] = bundleId
            }
            
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecDuplicateItem {
                try updateToken(key: key ?? tokenKey, token: token)
            }
            guard status == errSecSuccess else {
                print("\(tag) failed save token in Keychain \(status.description)")
                throw KeychainError.unknown(status)
            }
        }
    }

    func getToken(forKey key: String? = nil) -> String? {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key ?? tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        if let bundleId = Bundle.main.bundleIdentifier {
            query[kSecAttrService as String] = bundleId
        }
        
        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func updateToken(key: String? = nil, token: String) throws {
        if let token = token.data(using: .utf8) {
            var query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key ?? tokenKey,
            ]
            if let bundleId = Bundle.main.bundleIdentifier {
                query[kSecAttrService as String] = bundleId
            }
            
            let attributes: [String: Any] = [
                kSecValueData as String: token
            ]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            guard status == errSecSuccess else {
                print("\(tag) failed update token in Keychain \(status.description)")
                throw KeychainError.unknown(status)
            }
        }
    }
    
    /// Clear all value in the given Keychain classes
    /// The default clear class is [kSecClassGenericPassword] which is used for auth token
    ///
    ///
    /// @param additionalClasses is the additional classes that you used in Keychain.
    /// If you have multiple classes in Keychain, you should pass all the classed you used to this param and
    /// call this function when logout
    func clearAllKeychain(additionalClasses: [CFString] = []) throws {
        let classes: [CFString] = [kSecClassGenericPassword] + additionalClasses
        
        for itemClass in classes {
            let query: [String: Any] = [
                kSecClass as String: itemClass
            ]
            let status = SecItemDelete(query as CFDictionary)
            
            guard status == errSecSuccess else {
                print("\(tag) failed to clear Keychain \(itemClass) \(status.description)")
                throw KeychainError.unknown(status)
            }
        }
    }
}
