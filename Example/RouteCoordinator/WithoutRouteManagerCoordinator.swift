//
//  WithoutRouteManagerCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class WithoutRouteManagerCoordinator: RouteCoordinator {
    required init(parameter: [String : Any]?, completion: ((Result<Data, Error>) -> Void)?) {
        super.init(parameter: parameter, completion: completion)
        
        if let parameter = parameter {
            print(parameter)
        } else {
            print("No parameter provided")
        }
    }
    
    private func makeViewController() -> WithoutRouteManagerViewController {
        let viewController = WithoutRouteManagerViewController.create()
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
