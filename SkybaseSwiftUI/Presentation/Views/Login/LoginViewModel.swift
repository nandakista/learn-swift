//
//  LoginViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 30/10/24.
//

import Foundation

final class LoginViewModel: BaseViewModel<Any> {
    private let dataSource: IDummyDataSource
    
    init(dataSource: IDummyDataSource) {
        self.dataSource = dataSource
    }
    
    @MainActor func onLogin(with authManager: AuthManager) {
        showLoadingDialog()
        dataSource.login()
            .sink(
                receiveCompletion: handleCompletion,
                receiveValue: { [weak self] user in
                    Task {
                        await authManager.setAuth();
                        print("users: \(user)")
                        self?.dismissLoadingDialog()
                    }
                }
            )
            .store(in: &cancellables)
    }
}
