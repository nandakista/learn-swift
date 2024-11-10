//
//  GithubUserDetailViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    private let username: String
    
    init(dataSource: IGithubDataSource, username: String) {
        self.dataSource = dataSource;
        self.username = username
        super.init()
        Task { await onRefresh() }
    }
    
    func onRefresh() async {
        await onLoadGithubUserDetail()
    }
    
    @MainActor
    func onLoadGithubUserDetail() async {
        self.loadingState()
        do {
            try await Task.sleep(for: .seconds(1))
            let user = try await self.dataSource.getUsersDetail(username: username).async()
            self.loadFinish(data: user)
        } catch {
            self.loadError(error: error.localizedDescription)
        }
    }
}
