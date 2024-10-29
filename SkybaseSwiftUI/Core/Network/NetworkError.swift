//
//  NetworkError.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 28/10/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case badURLResponse(url: URL, statusCode: Int)
    case notConnectedToInternet
    case requestTimeout
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case serviceUnavailable
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
            case .badURL:
                return "[🔥] The URL is invalid."
            case .badURLResponse(let url, let statusCode):
                return "[🔥] Bad response from URL: \(url). Status code: \(statusCode)"
            case .notConnectedToInternet:
                return "[🛜] No internet connection."
            case .requestTimeout:
                return "[🛜] The request timed out."
            case .unauthorized:
                return "[🚫] (401) Unauthorized access. Please login again."
            case .badRequest:
                return "[‼️] (400) Bad request"
            case .forbidden:
                return "[🚫] (403) Forbidden. You do not have permission to access this resource."
            case .notFound:
                return "[⁉️] (404) Sorry the resource you requested was not found."
            case .internalServerError:
                return "[⚠️] (500) The server encountered an internal error. Please try again later."
            case .badGateway:
                return "[⚠️] (502) Bad Gateway. The server received an invalid response."
            case .serviceUnavailable:
                return "[⚠️] (503) Service temporary unavailable. Please try again later."
            case .unknown(let error):
                return "[⚠️] Unknown error occurred: \(error.localizedDescription)"
        }
    }
}
