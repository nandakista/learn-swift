//
//  LoginView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: AuthManager
    @StateObject private var viewModel = LoginViewModel(dataSource: DummyDataSource())
    
    var body: some View {
        VStack {
            Button("Login") {
                viewModel.onLogin(with: authManager)
            }
        }
        .loadingDialog(
            isShowing: $viewModel.isLoadingDialog
        )
    }
}

#Preview {
    LoginView()
}
