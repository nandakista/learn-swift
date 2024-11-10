//
//  DataTaskExtension.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 10/11/24.
//

import Combine
import Foundation

extension Publisher {
    /// Converts a Combine Publisher to an async function that returns the publisher's output or throws an error.
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = self
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                }, receiveValue: { value in
                    continuation.resume(returning: value)
                    cancellable?.cancel()
                })
        }
    }
}
