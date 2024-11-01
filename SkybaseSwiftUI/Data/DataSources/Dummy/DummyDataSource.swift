//
//  DummyDataSource.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation
import Combine

class DummyDataSource: IDummyDataSource {
    func login(username: String, password: String) -> AnyPublisher<Login, Error> {
        return NetworkRequest.post(
            path: "/users",
            body: [
                "name": username,
                "job": password
            ],
            baseUrl: "https://reqres.in/api"
        )
        .decode(type: User.self, decoder: JSONDecoder())
        //
        // TODO: Development purpose only
        // fill your actual Github Token to [gitToken]
        // You can get github token in: Profile > Settings > Developer Settings > Personal access tokens
        //
        .map({ user in
            return Login(user: user, token: gitToken);
        })
        .eraseToAnyPublisher()
    }
}
