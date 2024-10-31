//
//  GithubUserDetailViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    
    init(dataSource: IGithubDataSource, username: String) {
        self.dataSource = dataSource;
        super.init()
        onLoadGithubUserDetail(username: username)
    }
    
    func onLoadGithubUserDetail(username: String) {
        loadingState()
        dataSource.getUsersDetail(username: username)
            .sink(
                receiveCompletion: handleCompletion,
                receiveValue: { [weak self] user in
                    self?.loadFinish(data: user)
                })
            .store(in: &cancellables)
    }
}
