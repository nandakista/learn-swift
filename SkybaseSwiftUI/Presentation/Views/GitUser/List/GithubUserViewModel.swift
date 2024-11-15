//
//  GithubUserViewModel.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubUserViewModel: BaseViewModel<GithubUser> {
    private let dataSource: IGithubDataSource
    
    init(dataSource: IGithubDataSource) {
        self.dataSource = dataSource
        super.init()
        Task { await onLoadGithubUser() }
    }
    
    func onLoadNext() async {
        await onLoadGithubUser(keepAlive: true, page: page + 1)
    }
    
    func onRefresh() async {
        await onLoadGithubUser(keepAlive: true, page: 1)
    }
    
    @MainActor
    func onLoadGithubUser(keepAlive: Bool = false, page: Int = 1) async {
        self.loadingState(keepAlive: keepAlive)
        do {
            let users = try await self.dataSource.getUsers(page: page, perPage: self.perPage).async()
            self.loadFinish(page: page, list: users)
        } catch {
            self.loadError(error: error.localizedDescription)
        }
    }
}
