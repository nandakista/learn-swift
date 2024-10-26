//
//  GithubDataSource.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class UserListDataSource {
    @Published var allUsers: [GithubUser] = []
    var githubUserSubscription: AnyCancellable?
    
    init() {
        getUsers()
    }
    
    private func getUsers() {
        guard let url = URL(string: "https://api.github.com/search/users?q=nanda&page=1&per_page=10") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        githubUserSubscription = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                print("data \(output.response)")
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: ResponseList<GithubUser>.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch user list: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (resultUsers) in
                print("Data List nih \(resultUsers.data)")
                self?.allUsers = resultUsers.data
                self?.githubUserSubscription?.cancel()
            }
    }
}
