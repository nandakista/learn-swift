//
//  LoginViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import Foundation

final class LoginViewModel: BaseViewModel<Any> {
    @MainActor func onLogin(with authManager: AuthManager) {
           showLoadingDialog()
           Task {
               try? await Task.sleep(for: Duration.seconds(2))
               await authManager.setAuth();
               dismissLoadingDialog()
           }
       }
}
