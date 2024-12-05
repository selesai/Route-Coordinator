//
//  RouteError.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 15/11/23.
//

import Foundation

/**
    An enumeration representing errors related to routing in the application.
 */
public enum RouteError: Error {
    /// Error indicating a problem with encoding data.
    case encodingError
    /// Error indicating a problem with decoding data.
    case decodingError
    /// Error indicating that there is no matching route for a given path.
    case noMatchingRoute
    /// Error indicating that a route with the same path already exists.
    case routeAlreadyExists
    /// Error indicating that the provided route path is not acceptable.
    case notAcceptableRoutePath
    /// Error indicating that a required parameter is not provided.
    case parameterNotProvided
    /// Error indicating that the provided parameter is not acceptable.
    case notAcceptableParameter
}

extension RouteError: CustomStringConvertible, CustomDebugStringConvertible {
    /**
        A textual representation of the error for display purposes.
     
        - Returns:
            A human-readable description of the error.
     */
    public var description: String {
        switch self {
        case .decodingError:
            return "Decoding error"
        case .encodingError:
            return "Encoding error"
        case .noMatchingRoute:
            return "No matching route"
        case .routeAlreadyExists:
            return "Route already exists"
        case .notAcceptableRoutePath:
            return "Route path not acceptable"
        case .parameterNotProvided:
            return "Parameter not provided"
        case .notAcceptableParameter:
            return "Parameter not acceptable"
        }
    }

    /**
        A textual representation of the error for debugging purposes.
     
        - Returns:
            The same human-readable description as `description`.
     */
    public var debugDescription: String {
        return description
    }
}
