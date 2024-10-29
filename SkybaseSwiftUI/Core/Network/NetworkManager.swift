//
//  NetworkManager.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/24.
//

import Foundation
import Combine

class NetworkManager {
    static let baseURL = URL(string: "https://api.github.com")!
    
    static func get(path: String, queryParam: [URLQueryItem]? = nil) -> AnyPublisher<Data, any Error> {
        var urlComponents: URLComponents = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
        )!
        
        if let queryParam = queryParam {
            urlComponents.queryItems = queryParam
        }
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .mapError { error -> Error in
                // Handle specific URLSession errors
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                        case NSURLErrorNotConnectedToInternet:
                            return NetworkError.notConnectedToInternet
                        case NSURLErrorTimedOut:
                            return NetworkError.requestTimeout
                        default:
                            return NetworkError.unknown(error)
                    }
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: url, statusCode: -1) // // -1 for unknown status code
        }
        
        switch httpResponse.statusCode {
            case 200...299:
                return output.data
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500:
                throw NetworkError.internalServerError
            case 502:
                throw NetworkError.badGateway
            case 503:
                throw NetworkError.serviceUnavailable
            default:
                throw NetworkError.badURLResponse(url: url, statusCode: httpResponse.statusCode)
        }
    }
}
