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
    
    func onLoadNext() {
        onLoadGithubUser(page: page + 1)
    }
    
    func onLoadGithubUser(page: Int = 1) {
        loadingState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dataSource.getUsers(page: page, perPage: self.perPage)
                .sink(
                    receiveCompletion: self.handleCompletion,
                    receiveValue: { [weak self] users in
                        self?.loadFinish(page: page, list: users)
                    }
                )
                .store(in: &self.cancellables)
        }
    }
    
}
