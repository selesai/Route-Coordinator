//
//  RouteParameter.swift
//  RouteCoordinator
//
//  Created by Marsudi Widodo on 15/12/23.
//

import Foundation

/**
    A type alias for a type that can be used as a route parameter and is Encodable.
 */
public typealias RouteParameter = Encodable

extension Encodable where Self: RouteParameter {
    var asDictionary: [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let decoded = try JSONSerialization.jsonObject(with: data, options: [])
            return decoded as? [String: Any]
        } catch {
            return nil
        }
    }
}
