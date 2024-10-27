//
//  GithubUserViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: BaseViewModel<GithubUser> {
    private let dataSource = GithubDataSource()
    
    override init() {
        /* TODO: Preview Mode
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
         self.allUsers.append(DeveloperPreview.instance.githubUser)
         })
         */
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
