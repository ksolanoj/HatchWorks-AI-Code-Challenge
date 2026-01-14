//
//  API.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import Foundation

/// Enum with the API logic
enum API {

    // MARK: - Base API Info
    static let scheme = "https"
    static let host = "restcountries.com"
    static let basePath = "/v3.1"

    // MARK: - Endpoints
    enum Endpoint {
        case all(fields: [Field])
        case name(String)

        var path: String {
            switch self {
            case .all:
                return basePath + "/all"
            case .name(let name):
                return basePath + "/name/\(name)"
            }
        }

        var queryItems: [URLQueryItem] {
            switch self {
            case .all(let fields):
                return [
                    URLQueryItem(name: "fields", value: fields.map(\.rawValue).joined(separator: ","))
                ]
            case .name:
                return []
            }
        }
    }

    // MARK: - Request Fields
    enum Field: String {
        case name
        case flags
        case population
        case continents
    }

    /// Method that returns the URL of the specified Endpoint
    /// - Parameter endpoint: Requested Endpoint
    /// - Returns: URL of the requested Endpoint
    static func makeURL(_ endpoint: Endpoint) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid endpoint: \(endpoint)")
        }
        return url
    }
}

/// Enum used to handle request errors
enum RequestError: Error {
    case somethingWentWrong
    case requestError(Error)
}
