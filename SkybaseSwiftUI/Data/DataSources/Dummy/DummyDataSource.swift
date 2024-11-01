//
//  DummyDataSource.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation
import Combine

class DummyDataSource: IDummyDataSource {
    func login() -> AnyPublisher<Login, Error> {
        return NetworkRequest.post(
            path: "/users",
            body: [
                "name": "Zeus",
                "job": "iOS Developer"
            ],
            baseUrl: "https://reqres.in/api"
        )
        .decode(type: User.self, decoder: JSONDecoder())
        .map({ user in
            return Login(user: user, token: "token-dummy-Xcad32pt47cxn");
        })
        .eraseToAnyPublisher()
    }
}
