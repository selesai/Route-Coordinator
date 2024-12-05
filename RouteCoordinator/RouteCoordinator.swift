//
//  RouteCoordinator.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 09/12/2023.
//  Copyright (c) 2023 Marsudi Widodo. All rights reserved.
//

import Foundation
import UIKit

/**
    A type alias for a class that acts as both a Route and a Coordinator.
 */
public typealias RouteCoordinator = Route & Coordinator

/**
    A type alias for a type that can be used as a received from route parameter and is Decodable.
 */
public typealias RouteValue = Decodable

/**
    A protocol for defining a route in the application.

    - Note:
        This protocol requires conforming types to provide a unique path associated with the route and a method to perform the actual navigation when the route is triggered.
 */
public protocol Route {
    /// The unique path associated with the route.
    static var path: String { get }
    /// Method to perform the actual navigation when the route is triggered.
    func route()
}

/**
    Default implementation of the `Route` protocol, providing an empty `route()` method.
 */
public extension Route {
    static var path: String { "" }
    func route() { }
}

/**
    Protocol defining a type that can be transformed into a specific RouteData type.
 */
public protocol Transformable {
    associatedtype RouteData
}

/**
    Base class for coordinators, responsible for managing navigation and data flow in the application.

    - Warning:
        Subclasses must ensure to properly initialize the `navigationController` property.
 */
open class Coordinator: NSObject {
    
    /// The navigation controller managed by the coordinator.
    public var navigationController: UINavigationController?
    
    /// Dictionary of parameters associated with the coordinator.
    public var parameter: [String: Any]?
    
    /// Completion closure to handle the result of a coordinator's operation.
    public var completion: ((Result<Data, Error>) -> Void)?
    
    /// JSON decoder used for decoding data into Decodable types.
    public let decoder = JSONDecoder()
    
    /// JSON encoder used for encoding Encodable into Data types.
    public let encoder = JSONEncoder()
    
    /**
        Initializes a new Coordinator.

        - Parameters:
        - parameter: A dictionary containing route parameters in key-value pairs. This can be used
        to provide additional information required for the coordinator's task.
        - completion: An optional closure that handles the result of the coordinator's operation.
        The result is passed as a `Result<Data, Error>`, allowing success or failure to be captured.

        The initializer sets up the coordinator with the provided parameters and prepares it to execute
        its tasks. The completion closure allows handling of the operation result, typically involving
        data or error handling.
     */
    public required init(
        parameter: [String: Any]?,
        completion: ((Result<Data, Error>) -> Void)?
    ) {
        self.completion = completion
        self.parameter = parameter
    }
    
    /**
        Transforms the data into a Decodable type using a generic method.

        - Parameter type: The type to which the data should be transformed.

        - Returns: A result indicating success with the decoded value or failure with an error.
     */
    public final func transform<T: Decodable>(to type: T.Type) -> Result<T, Error> {
        if let parameter = parameter {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameter, options: [])
                let decoded = try self.decoder.decode(type, from: data)
                return .success(decoded)
            } catch {
                #if DEBUG
                print("--- route error ---", error)
                print("--- decoding object from dictionary ---", type)
                #endif
                return .failure(error)
            }
        } else {
            #if DEBUG
            print("--- route error ---", RouteError.parameterNotProvided)
            #endif
            return .failure(RouteError.parameterNotProvided)
        }
    }
}

/**
    Extension providing a default implementation for types conforming to Transformable, RouteCoordinator, and having RouteData as Decodable.
 */
public extension Transformable where RouteData: RouteValue, Self: RouteCoordinator {
    /**
        Transforms the associated parameter into the specified RouteData type.
     
        - Returns: An optional RouteData object if transformation succeeds, nil otherwise.
     */
    var transformedParameter: RouteData? {
        // Attempt to transform the data into the specified Decodable type
        let transform = self.transform(to: RouteData.self)
        
        switch transform {
        case .success(let parameter):
            return parameter
        case .failure(let error):
            // Pass the failure to the completion handler if provided
            #if DEBUG
            print("--- route error ---", error)
            #endif
            completion?(.failure(error))
            return nil
        }
    }
}
