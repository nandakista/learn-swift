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
    
    private let dataSource = UserListDataSource()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.allUsers.append(DeveloperPreview.instance.githubUser)
            })
         */
        onLoadGithubUser()
    }
    
    func onLoadGithubUser() {
        dataSource.$allUsers
            .sink { (responseUsers) in
                self.allUsers = responseUsers
            }
            .store(in: &cancellable)
    }
}
