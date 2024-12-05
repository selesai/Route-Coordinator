//
//  BasicCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class BasicCoordinator: RouteCoordinator {
    
    static var path: String { RouteConstant.basic }
    
    private func makeViewController() -> BasicViewController {
        let viewController = BasicViewController.create()
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
