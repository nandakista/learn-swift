//
//  SplashViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/10/24.
//

import Foundation

enum AuthState {
    case initial
    case unauthenticated
    case authenticated
}

final class AuthManager: ObservableObject {
    private let tag = "AuthManager::=>"
    
    static let shared = AuthManager()
    @MainActor @Published private(set) var authState: AuthState = .initial
    
    private func log(_ text: String) -> Void { print("\(tag) \(text)")}
    
    private init() {
        Task { await self.checkIsLoggedIn() }
    }
    
    func checkIsLoggedIn() async {
        if let token = KeychainManager.shared.getToken() {
            log("isLoggedIn, token: \(token)")
            token.isEmpty ? await setUnauth() : await setAuth()
        } else {
            await setUnauth()
        }
    }
    
    func login(user: User?, token: String?) async {
        guard let user = user else {
            log("Failed login cause the user data is nil or empty")
            return
        }
        guard let token = token else {
            log("Failed login cause the token is nil or empty")
            return
        }
        await setAuthData(user: user, token: token)
        await setAuth()
    }
    
    func logout() async {
        try? KeychainManager.shared.clearAllKeychain()
        try? await Task.sleep(for: Duration.seconds(1)) // TODO: Need to clear this in production
        await setUnauth()
    }
    
    func setAuthData(user: User, token: String) async {
        try? KeychainManager.shared.saveToken(token)
    }
    
    @MainActor
    func setAuth() {
        self.authState = .authenticated
        log("Set \(self.authState)")
    }
    
    @MainActor
    func setUnauth() {
        self.authState = .unauthenticated
        log("Set \(self.authState)")
    }
}
