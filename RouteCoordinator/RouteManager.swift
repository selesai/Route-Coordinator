//
//  RouteManager.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 15/11/23.
//

import Foundation

/**
    The central manager responsible for coordinating and handling routes in the application.
 */
final public class RouteManager {
    
    /// Shared instance of the `RouteManager` to be used throughout the application.
    public static let shared = RouteManager()
    
    /// Registry to manage and store registered coordinators.
    private let coordinatorRegistry = CoordinatorRegistry()
    
    /// JSON encoder used for encoding route parameters.
    private let encoder = JSONEncoder()
    
    /// JSON decoder used for decoding route data.
    private let decoder = JSONDecoder()
    
    /// Private initializer to ensure a single shared instance.
    private init() {}
    
    /**
        Registers a coordinator type with the `CoordinatorRegistry`.
     
        - Parameter coordinatorType: The type of coordinator to register.
     */
    public func register(coordinatorType: RouteCoordinator.Type) {
        coordinatorRegistry.register(coordinatorType: coordinatorType)
    }
    
    /**
        Registers multiple coordinator types with the `CoordinatorRegistry`.
     
        - Parameter coordinatorTypes: The types of coordinators to register.
     */
    public func register(_ coordinatorTypes: RouteCoordinator.Type...) {
        for coordinatorType in coordinatorTypes {
            coordinatorRegistry.register(coordinatorType: coordinatorType)
        }
    }
    
    /**
        Removes all registered coordinators from the `CoordinatorRegistry`.
     */
    public func removeAll() {
        coordinatorRegistry.removeAllCoordinators()
    }
    
    /**
        Routes to a coordinator and handles the result with the specified completion closure.
     
        - Parameters:
            - path: The unique path associated with the route.
            - parameter: Optional route parameters conforming to `RouteParameter`.
            - navigationController: The navigation controller to use for navigation.
            - completion: The closure to be executed with the result of the route operation.
     */
    public func route<T: RouteResponse>(
        path: String,
        with parameter: RouteParameter? = nil,
        navigationController: UINavigationController?,
        completion: ((Result<T, Error>) -> Void)? = nil
    ) {
        guard let coordinatorType = coordinatorRegistry.coordinatorType(forPath: path) else {
            if let completion = completion {
                completion(.failure(RouteError.noMatchingRoute))
            }
            return
        }
        
        let parameter = parameter?.asDictionary
        let coordinator = coordinatorType.init(parameter: parameter) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try self.decoder.decode(T.self, from: data)
                    completion?(.success(decodedObject))
                } catch {
                    completion?(.failure(RouteError.decodingError))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        coordinator.navigationController = navigationController
        coordinator.route()
    }
    
    /**
     Routes to a coordinator and handles the result with the specified completion closure.
     
     - Parameters:
         - path: The unique path associated with the route.
         - parameter: Optional route parameters conforming to `RouteParameter`.
         - navigationController: The navigation controller to use for navigation.
         - completion: The closure to be executed with the result of the route operation.
     */
    public func route(
        path: String,
        with parameter: RouteParameter? = nil,
        navigationController: UINavigationController?,
        completion: ((Result<Data, Error>) -> Void)? = nil
    ) {
        guard let coordinatorType = coordinatorRegistry.coordinatorType(forPath: path) else {
            if let completion = completion {
                completion(.failure(RouteError.noMatchingRoute))
            }
            return
        }
        
        let parameter = parameter?.asDictionary
        let coordinator = coordinatorType.init(parameter: parameter, completion: completion)
        coordinator.navigationController = navigationController
        coordinator.route()
    }
    
    /**
        Routes to a coordinator and handles the result with the specified completion closure.
     
        - Parameters:
            - path: The unique path associated with the route.
            - parameter: Optional route parameters conforming as [String: Any].
            - navigationController: The navigation controller to use for navigation.
            - completion: The closure to be executed with the result of the route operation.
     */
    public func route<T: RouteResponse>(
        path: String,
        with parameter: [String: Any],
        navigationController: UINavigationController?,
        completion: ((Result<T, Error>) -> Void)? = nil
    ) {
        guard let coordinatorType = coordinatorRegistry.coordinatorType(forPath: path) else {
            if let completion = completion {
                completion(.failure(RouteError.noMatchingRoute))
            }
            return
        }
        
        let coordinator = coordinatorType.init(parameter: parameter) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try self.decoder.decode(T.self, from: data)
                    completion?(.success(decodedObject))
                } catch {
                    completion?(.failure(RouteError.decodingError))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        coordinator.navigationController = navigationController
        coordinator.route()
    }
    
    /**
     Routes to a coordinator and handles the result with the specified completion closure.
     
     - Parameters:
         - path: The unique path associated with the route.
         - parameter: Optional route parameters conforming as [String: Any].
         - navigationController: The navigation controller to use for navigation.
         - completion: The closure to be executed with the result of the route operation.
     */
    public func route(
        path: String,
        with parameter: [String: Any],
        navigationController: UINavigationController?,
        completion: ((Result<Data, Error>) -> Void)? = nil
    ) {
        guard let coordinatorType = coordinatorRegistry.coordinatorType(forPath: path) else {
            if let completion = completion {
                completion(.failure(RouteError.noMatchingRoute))
            }
            return
        }
        
        let coordinator = coordinatorType.init(parameter: parameter, completion: completion)
        coordinator.navigationController = navigationController
        coordinator.route()
    }
}
