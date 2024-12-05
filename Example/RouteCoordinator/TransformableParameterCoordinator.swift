//
//  TransformableParameterCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class TransformableParameterCoordinator: RouteCoordinator, Transformable {
    
    typealias RouteData = RouteDataValue
    
    static var path: String { RouteConstant.transformedParameter }
    
    private func makeViewController() -> TransformableParameterViewController {
        
        let title = transformedParameter?.title
        
        let viewController = TransformableParameterViewController.create(with: title)
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TransformableParameterCoordinator {
    struct RouteDataValue: RouteValue {
        let title: String
    }
}
