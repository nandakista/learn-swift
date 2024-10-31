//
//  ProfileViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 27/10/24.
//

import Foundation

class ProfileViewModel : BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    
    private let authManager = AuthManager.shared // TODO: Why using singleton doesn't work ?
    
    init(dataSource: IGithubDataSource) {
        self.dataSource = dataSource
        super.init()
        onGetProfile()
    }
    
    func onGetProfile() {
        loadingState()
        dataSource.getUsersDetail(username: "nandakista")
            .sink(
                receiveCompletion: handleCompletion,
                receiveValue: { [weak self] user in
                    self?.loadFinish(data: user)
                }
            )
            .store(in: &cancellables)
    }
    
    @MainActor func onLogout(with authManager: AuthManager) {
        Task {
            showLoadingDialog()
            await authManager.setUnauth()
            dismissLoadingDialog()
        }
    }
}
