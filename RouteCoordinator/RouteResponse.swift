//
//  RouteResponse.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 18/03/24.
//

import Foundation

/**
 A type alias for a type that can be used as a received from completion and is Decodable.
 */
public typealias RouteResponse = Decodable

extension Result<Data, Error> {
    public func toRouteResponse<T: RouteResponse>(to type: T.Type) -> T? {
        switch self {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    return result
                } catch {
                    return nil
                }
            case .failure:
                return nil
        }
    }
}
