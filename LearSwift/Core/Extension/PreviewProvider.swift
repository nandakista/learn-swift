//
//  PreviewProvider.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let githubUserViewModel = GithubUserViewModel()
    
    let githubUser = GithubUser(
        id: 1,
        username: "juan",
        name: "Juan Chavez",
        location: "California",
        company: "Sac Corp",
        gitUrl: "github.com/juan",
        bio: "Mobile Developer",
        avatarUrl: "https://ui-avatars.com/api/?name=John+Doe",
        repository: 20,
        followers: 300,
        following: 200,
        repositoryList: [],
        followersList: [],
        followingList: []
    )
}
