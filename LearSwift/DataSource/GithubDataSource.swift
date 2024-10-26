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
        guard let url = URL(string: "https://api.github.com/search/users?q=nanda&page=1&per_page=10") else {
            print("Invalid URL")
            return
        }
        
        githubUserSubscription = NetworkManager.get(url: url)
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
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            print("Invalid URL")
            return
        }
        
        githubUserDetailSubscription = NetworkManager.get(url: url)
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
