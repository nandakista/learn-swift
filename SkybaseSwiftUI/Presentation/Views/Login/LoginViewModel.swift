//
//  LoginViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import Foundation

final class LoginViewModel: BaseViewModel<Login> {
    private let dataSource: IDummyDataSource
    
    @Published var usernameField = ValidatedField(rules: [NonEmptyRule()])
    @Published var passwordField = ValidatedField(rules: [NonEmptyRule(), MinLengthRule(length: 8)])
    
    func validateAllFields() -> Bool {
        usernameField.validate()
        passwordField.validate()
        return usernameField.error == nil && passwordField.error == nil
    }
    
    init(dataSource: IDummyDataSource) {
        self.dataSource = dataSource
    }
    
    @MainActor
//    func onLogin(username: String, password: String) {
    func onLogin() {
        guard validateAllFields() else { return }
        showLoadingDialog()
        if (passwordField.text != "iOS Developer" || usernameField.text != "Zeus") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.loadError(error: "Invalid credentials !")
                return
            })
        } else {
            dataSource.login(username: usernameField.text, password: passwordField.text)
                .sink(
                    receiveCompletion: handleCompletion,
                    receiveValue: { [weak self] data in
                        Task {
                            print("response data: \(data)")
                            await AuthManager.shared.login(user: data.user, token: data.token);
                            self?.dismissLoadingDialog()
                        }
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    @MainActor
    func onBypassLogin() {
        showLoadingDialog()
        dataSource.login(username: "Zeus", password: "iOS Developer")
            .sink(
                receiveCompletion: handleCompletion,
                receiveValue: { [weak self] data in
                    Task {
                        print("response data: \(data)")
                        await AuthManager.shared.login(user: data.user, token: data.token);
                        self?.dismissLoadingDialog()
                    }
                }
            )
            .store(in: &cancellables)
    }
}
