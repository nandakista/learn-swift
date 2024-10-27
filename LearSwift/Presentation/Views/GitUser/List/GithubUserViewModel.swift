//
//  GithubUserViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    
    init(dataSource: IGithubDataSource) {
        /* TODO: Preview Mode
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
         self.allUsers.append(DeveloperPreview.instance.githubUser)
         })
         */
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
