//
//  GithubDataSource.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubDataSource {
    @Published var allUsers: [GithubUser] = []
    var githubUserSubscription: AnyCancellable?
    
    @Published var user: GithubUser?
    var githubUserDetailSubscription: AnyCancellable?
    
    func getUsers() {
        githubUserSubscription = NetworkManager.get(
            path: "/search/users",
            queryParam: [
                URLQueryItem(name: "q", value: "nanda"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "per_page", value: "10"),
            ]
        )
        .decode(type: ResponseList<GithubUser>.self, decoder: JSONDecoder())
        .sink(
            receiveCompletion: NetworkManager.handleCompletion,
            receiveValue: { [weak self] resultUsers in
                self?.allUsers = resultUsers.data
                self?.githubUserSubscription?.cancel()
            }
        )
    }
    
    func getUsersDetail(username: String) {
        githubUserDetailSubscription = NetworkManager.get(path: "/users/\(username)")
            .decode(type: GithubUser.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] user in
                    self?.user = user
                    self?.githubUserDetailSubscription?.cancel()
                }
            )
    }
}
