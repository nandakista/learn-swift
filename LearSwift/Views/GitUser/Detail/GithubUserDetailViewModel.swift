//
//  GithubUserDetailViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation

class GithubUserDetailViewModel: ObservableObject {
    @Published var user: GithubUser?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.user = DeveloperPreview.instance.githubUser
        })
    }
}
