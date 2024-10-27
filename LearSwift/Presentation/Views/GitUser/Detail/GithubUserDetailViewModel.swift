//
//  GithubUserDetailViewModel.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: ObservableObject {
    private var dataSource = GithubDataSource()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var user: GithubUser?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(username: String) {
        /* TODO: Preview Mode
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.user = DeveloperPreview.instance.githubUser
            })
         */
        onLoadGithubUserDetail(username: username)
    }
    
    func onLoadGithubUserDetail(username: String) {
        isLoading = true
        errorMessage = nil
        
        dataSource.getUsersDetail(username: username)
            .sink { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.isLoading = false
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.isLoading = false
            }
            .store(in: &cancellable)
    }
}
