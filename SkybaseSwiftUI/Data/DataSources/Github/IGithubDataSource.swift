//
//  IGithubDataSource.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 28/10/24.
//

import Foundation
import Combine

protocol IGithubDataSource {
    func getUsers(page: Int, perPage: Int) -> AnyPublisher<[GithubUser], any Error>
    func getUsersDetail(username: String) -> AnyPublisher<GithubUser, any Error>
    func getGitRepository() -> AnyPublisher<[Repo], any Error>
}
