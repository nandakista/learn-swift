//
//  GithubUser.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/08/24.
//

import Foundation

struct GithubUser: Identifiable, Codable {
    let id : Int
    let username: String?
    let name: String?
    let location: String?
    let company: String?
    let gitUrl: String?
    let bio: String?
    let avatarUrl: String?
    let repository: Int?
    let followers: Int?
    let following: Int?
    let repositoryList: [Repo]?
    let followersList: [GithubUser]?
    let followingList: [GithubUser]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case name
        case location
        case company
        case gitUrl = "html_url"
        case bio
        case avatarUrl = "avatar_url"
        case repository = "public_repos"
        case followers
        case following
        case repositoryList = "repository_list"
        case followersList = "followers_list"
        case followingList = "following_list"
    }
}
