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
            
            VStack(
                alignment: .leading,
                content: {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.15).cornerRadius(10))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    if isSubmitted && username.isEmpty {
                        Text("Field can not be empty!")
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 0)}
                }
            )
            .padding(.horizontal)
            
            VStack(
                alignment: .leading,
                content: {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.15).cornerRadius(10))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    if isSubmitted && password.isEmpty {
                        Text("Field can not be empty!")
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 0)
                    }
                }
            )
            .padding(.horizontal)
            
            Button(action: {
                isSubmitted = true
                if (username.isEmpty || password.isEmpty) { return }
                viewModel.onLogin(username: username, password: password)
            }) {
                Text("Log In")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(viewModel.isLoading)
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
