//
//  RequestState.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 04/11/24.
//

enum RequestState {
    case initial
    case empty
    case loading
    case success
    case error
}

extension RequestState {
    var isInitial: Bool {
        return self == .initial
    }

    var isEmpty: Bool {
        return self == .empty
    }

    var isLoading: Bool {
        return self == .loading
    }

    var isSuccess: Bool {
        return self == .success
    }

    var isError: Bool {
        return self == .error
    }
}
