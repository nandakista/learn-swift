//
//  GithubUserDetailViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: ObservableObject {
    @Published var user: GithubUser?
    private var dataSource = UserDetailDataSource()
    
    init(username: String) {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.user = DeveloperPreview.instance.githubUser
            })
         */
        dataSource.$user.assign(to: &$user)
        onLoadGithubUserDetail(username: username)
    }
    
    func onLoadGithubUserDetail(username: String) {
        dataSource.getUsersDetail(username: username)
    }
}
