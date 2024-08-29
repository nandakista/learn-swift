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
    
    init() {
        getUsers()
    }
    
    private func getUsers() {
        guard let url = URL(string: "https://api.github.com/search/users?q=nanda&page=1&per_page=10") else {
            return
        }
        
        githubUserSubscription = URLSession.shared.dataTaskPublisher(for: url)
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
                    print("Got error: \(error)")
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (resultUsers) in
                print("data nih \(resultUsers.data)")
                self?.allUsers = resultUsers.data
                self?.githubUserSubscription?.cancel()
            }
    }
}
