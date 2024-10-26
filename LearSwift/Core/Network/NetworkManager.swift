//
//  NetworkManager.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 26/10/24.
//

import Foundation
import Combine

class NetworkManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL.  \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func get(url: URL) -> AnyPublisher<Data, any Error> {
        var request = URLRequest(url: url)
        request.setValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        print("data \(output.response)")
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Failed to get data: \(error.localizedDescription)")
        }
    }
}
