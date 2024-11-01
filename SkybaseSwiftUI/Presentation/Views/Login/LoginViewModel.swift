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
                receiveValue: { [weak self] data in
                    Task {
                        print("response data: \(data)")
                        await authManager.login(user: data.user, token: data.token);
                        self?.dismissLoadingDialog()
                    }
                }
            )
            .store(in: &cancellables)
    }
}
