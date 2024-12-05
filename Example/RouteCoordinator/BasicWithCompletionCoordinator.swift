//
//  BasicWithCompletionCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class BasicWithCompletionCoordinator: RouteCoordinator {
    
    static var path: String { RouteConstant.basicWithCompletion }
    
    private func makeViewController() -> BasicWithCompletionViewController {
        let viewController = BasicWithCompletionViewController.create(with: self)
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
