//
//  NetworkRequest.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation
import Combine

enum ContentType {
    case json
    case formURLEncoded
    case formData
}

class NetworkRequest {
    static func get(
        path: String,
        queryParam: [URLQueryItem]? = nil,
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, any Error> {
        do {
            let request = try NetworkManager.getURLRequest(
                method: "GET",
                path: path,
                queryParam: queryParam,
                baseUrl: baseUrl
            )
            return NetworkManager.handleRequest(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    static func post(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        do {
            let request = try NetworkManager.getURLRequest(
                method: "POST",
                path: path,
                contentType: contentType,
                body: body,
                baseUrl: baseUrl
            )
            return NetworkManager.handleRequest(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
     
    static func delete(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        do {
            let request = try NetworkManager.getURLRequest(
                method: "DELETE",
                path: path,
                contentType: contentType,
                body: body,
                baseUrl: baseUrl
            )
            return NetworkManager.handleRequest(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    static func put(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        do {
            let request = try NetworkManager.getURLRequest(
                method: "PUT",
                path: path,
                contentType: contentType,
                body: body,
                baseUrl: baseUrl
            )
            return NetworkManager.handleRequest(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    static func patch(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        do {
            let request = try NetworkManager.getURLRequest(
                method: "PATCH",
                path: path,
                contentType: contentType,
                body: body,
                baseUrl: baseUrl
            )
            return NetworkManager.handleRequest(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
