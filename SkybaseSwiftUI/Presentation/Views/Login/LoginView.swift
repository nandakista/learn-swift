//
//  LoginView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel(dataSource: DummyDataSource())
    
    var body: some View {
        VStack {
            Button("Bypass Login") {
                viewModel.onBypassLogin()
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
