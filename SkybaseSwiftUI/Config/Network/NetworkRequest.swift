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
    static func get(path: String, queryParam: [URLQueryItem]? = nil) -> AnyPublisher<Data, any Error> {
        let urlComponents = NetworkManager.getURLComponents(path: path, queryParam: queryParam)
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        return NetworkManager.handleRequest(request: request)
    }
    
    static func post(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        let urlComponents = NetworkManager.getURLComponents(path: path)
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        if let baseUrl = baseUrl {
            request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        request.setBody(contentType: contentType, body: body)
        return NetworkManager.handleRequest(request: request)
    }
     
    static func delete(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        let urlComponents = NetworkManager.getURLComponents(path: path)
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        if let baseUrl = baseUrl {
            request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        }
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        request.setBody(contentType: contentType, body: body)
        return NetworkManager.handleRequest(request: request)
    }
    
    static func put(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        let urlComponents = NetworkManager.getURLComponents(path: path)
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        if let baseUrl = baseUrl {
            request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        }
        
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        request.setBody(contentType: contentType, body: body)
        return NetworkManager.handleRequest(request: request)
    }
    
    static func patch(
        path: String,
        contentType: ContentType = .json,
        body: [String: Any],
        baseUrl: String? = nil
    ) -> AnyPublisher<Data, Error> {
        let urlComponents = NetworkManager.getURLComponents(path: path)
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        if let baseUrl = baseUrl {
            request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        }
        
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        request.setBody(contentType: contentType, body: body)
        return NetworkManager.handleRequest(request: request)
    }
}
