//
//  GithubUserViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: ObservableObject {
    private let dataSource = GithubDataSource()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var allUsers: [GithubUser] = [] {
        didSet {
            isEmpty = allUsers.isEmpty
        }
    }
    @Published var isEmpty: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.allUsers.append(DeveloperPreview.instance.githubUser)
            })
         */
        onLoadGithubUser()
    }
    
    func onLoadGithubUser() {
        isLoading = true
        errorMessage = nil
        
        dataSource.getUsers()
            .sink { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.errorMessage = "Failed to load users: \(error.localizedDescription)" // Handle error
                        self?.isLoading = false
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] users in
                self?.allUsers = users
                self?.isLoading = false
            }
            .store(in: &cancellable)
    }

}
