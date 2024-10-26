//
//  GithubUserViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: ObservableObject {
    @Published var allUsers: [GithubUser] = []
    private let dataSource = GithubDataSource()
    
    init() {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.allUsers.append(DeveloperPreview.instance.githubUser)
            })
         */
        dataSource.$allUsers.assign(to: &$allUsers)
        onLoadGithubUser()
    }
    
    func onLoadGithubUser() {
        dataSource.getUsers()
    }
}
