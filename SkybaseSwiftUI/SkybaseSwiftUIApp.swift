//
//  SkybaseSwiftUIApp.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 26/10/23.
//

import SwiftUI

@main
struct SkybaseSwiftUIApp: App {
    @StateObject var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            switch authManager.authState {
                case .initial:
                    SplashView()
                case .authenticated:
                    MainNavigationView()
                case .unauthenticated:
                    LoginView()
            }
        }
    }
}
