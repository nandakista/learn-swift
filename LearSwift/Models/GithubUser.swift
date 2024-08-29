//
//  GithubUser.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/08/24.
//

import Foundation

struct GithubUser: Identifiable {
    let id = UUID()
    var username: String
    var gitUrl: String
    var avatar: String
 }


var githubUsers = [
    GithubUser(username: "Juan Chavez", gitUrl: "https://github.com/juan-chavez", avatar: "https://ui-avatars.com/api/?name=John+Doe"),
    GithubUser(username: "Mei Chen", gitUrl: "https://github.com/mei-chen", avatar: "https://ui-avatars.com/api/?name=John+Doe")
]
