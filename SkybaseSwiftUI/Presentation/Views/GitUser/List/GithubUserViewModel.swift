//
//  GithubUserViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    
    init(dataSource: IGithubDataSource) {
        self.dataSource = dataSource
        super.init()
        onLoadGithubUser()
    }
    
    func onLoadGithubUser() {
        loadingState()
        dataSource.getUsers()
            .sink(
                receiveCompletion: handleCompletion,
                receiveValue: { [weak self] users in
                    self?.loadFinish(list: users)
                }
            )
            .store(in: &cancellables)
    }
    
}
