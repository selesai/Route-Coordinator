//
//  CoordinatorRegistry.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 15/11/23.
//

import Foundation

/**
    A registry for managing and storing registered coordinators in the application.
 */
final class CoordinatorRegistry {
    
    /// Dictionary to store registered coordinator types with their associated paths.
    private var registeredCoordinators = [String: RouteCoordinator.Type]()
    
    /**
        Registers a coordinator type with its associated path.
     
        - Parameters:
            - coordinatorType: The type of coordinator to register.
     
        - Throws:
            An error if the coordinator's path is empty or if a coordinator with the same path already exists.
     */
    func register(coordinatorType: RouteCoordinator.Type) {
        let path = coordinatorType.path
        
        guard path != ""
        else {
            return
        }
        
        if registeredCoordinators[path] != nil {
            fatalError(RouteError.routeAlreadyExists.description)
        } else {
            registeredCoordinators[path] = coordinatorType
        }
    }
    
    /**
        Retrieves the coordinator type associated with the given path.
     
        - Parameter path: The path associated with the coordinator type.
     
        - Returns:
            The type of the coordinator associated with the given path, or `nil` if not found.
     */
    func coordinatorType(forPath path: String) -> RouteCoordinator.Type? {
        return registeredCoordinators[path]
    }
    
    /**
        Removes all registered coordinators from the registry.
     */
    func removeAllCoordinators() {
        registeredCoordinators.removeAll()
    }
}
