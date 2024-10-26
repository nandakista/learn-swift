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
    var cancellable = Set<AnyCancellable>()
    private var dataSource: UserDetailDataSource?
    
    init(username: String) {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.user = DeveloperPreview.instance.githubUser
            })
         */
        self.dataSource = UserDetailDataSource(username: username)
        onLoadGithubUserDetail()
    }
    
    func onLoadGithubUserDetail() {
        dataSource?.$user
            .sink { responseUser in
                self.user = responseUser
            }
            .store(in: &cancellable)
    }
}
