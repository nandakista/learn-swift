//
//  File.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation

struct Repo: Codable, Hashable, Equatable {
    let name: String?
    let owner: GithubUser?
    let description: String?
    let language: String?
    let totalWatch: Int?
    let totalFork: Int?
    let totalStar: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case owner
        case description
        case language
        case totalWatch = "watchers_count"
        case totalFork = "forks_count"
        case totalStar = "stargazers_count"
    }
 }
