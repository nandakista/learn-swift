//
//  GithubDataSource.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation
import Combine

class GithubDataSource: IGithubDataSource {
    func getUsers() -> AnyPublisher<[GithubUser], any Error> {
        return NetworkRequest.get(
            path: "/search/users",
            queryParam: [
                URLQueryItem(name: "q", value: "nanda"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "per_page", value: "10"),
            ]
        )
        .decode(type: ResponseList<GithubUser>.self, decoder: JSONDecoder())
        .map({ responseList in
            return responseList.data;
        })
        .eraseToAnyPublisher()
    }
    
    func getUsersDetail(username: String) -> AnyPublisher<GithubUser, any Error> {
        return NetworkRequest.get(path: "/users/\(username)")
            .decode(type: GithubUser.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getGitRepository() -> AnyPublisher<[Repo], any Error> {
        return NetworkRequest.get(path: "")
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
