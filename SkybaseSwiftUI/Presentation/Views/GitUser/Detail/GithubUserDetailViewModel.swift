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
        Task { await onLoadGithubUserDetail() }
    }
    
    func onRefresh() async {
        await onLoadGithubUserDetail(keepAlive: true)
    }
    
    @MainActor
    func onLoadGithubUserDetail(keepAlive: Bool = false) async {
        self.loadingState(keepAlive: keepAlive)
        do {
            let user = try await self.dataSource.getUsersDetail(username: username).async()
            self.loadFinish(data: user)
        } catch {
            self.loadError(error: error.localizedDescription)
        }
    }
}
