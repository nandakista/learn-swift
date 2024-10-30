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
    @MainActor static let shared = AuthManager()
    @MainActor @Published private(set) var authState: AuthState = .initial
    
    @MainActor
    init() {
        Task {
            // Simulate checking if the user is authenticated
            // Replace with actual authentication logic
            await self.setAuth()
        }
    }
    
    @MainActor
    func setAuth() async {
        self.authState = .authenticated
        print("set auth \(self.authState)")
    }
    
    @MainActor
    func setUnauth() async {
        try? await Task.sleep(for: Duration.seconds(1))
        self.authState = .unauthenticated
        print("set unauth \(self.authState)")
    }
}
