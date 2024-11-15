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
    case loadingNext
    case success
    case error
    case errorNext
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
    
    var isLoadingNext: Bool {
        return self == .loadingNext
    }

    var isSuccess: Bool {
        return self == .success
    }

    var isError: Bool {
        return self == .error
    }
    
    var isErrorNext: Bool {
        return self == .errorNext
    }
}
