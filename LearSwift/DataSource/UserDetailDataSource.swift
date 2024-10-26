//
//  UserDetailDataSource.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/24.
//

import Foundation
import Combine

class UserDetailDataSource {
    @Published var user: GithubUser?
    var githubUserDetailSubscription: AnyCancellable?
    
    init(username: String) {
        getUsersDetail(username: username)
    }
    
    private func getUsersDetail(username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            print("Invalid URL")
            return
        }
        
        githubUserDetailSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: GithubUser.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch user data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (result) in
                self?.user = result
                print("Fetched user details: \(result)")
                self?.githubUserDetailSubscription?.cancel()
            }
    }
}
