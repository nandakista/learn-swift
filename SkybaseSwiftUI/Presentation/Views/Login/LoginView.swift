//
//  LoginView.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel(
        dataSource: DummyDataSource()
    )
    
    @State var username: String = ""
    @State var password: String = ""
    @State private var isSubmitted = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Skybase SwiftUI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 32)
            
            CustomTextField(
                title: "Username",
                text: $username,
                isError: isSubmitted && username.isEmpty
            )
            
            CustomTextField(
                title: "Password",
                text: $password,
                isError: isSubmitted && password.isEmpty
            )
            
            PrimaryButton(
                title: "Log In",
                disabled: viewModel.isLoading,
                action: {
                    isSubmitted = true
                    if (username.isEmpty || password.isEmpty) { return }
                    viewModel.onLogin(username: username, password: password)
                }
            )
            
            Text("or")
            Button("Bypass Login") {
                viewModel.onBypassLogin()
            }
        }
        .padding()
        .onTapDismissKeyboard()
        .loadingDialog(
            isShowing: $viewModel.isLoadingDialog
        )
        .alert(
            isPresented: $viewModel.isErrorDialog,
            content: {
                Alert(
                    title: Text(viewModel.errorDialogMessage ?? "Something went wrong"),
                    dismissButton: .default(Text("OK"))
                )
            }
        )
    }
}

#Preview {
    LoginView()
}
