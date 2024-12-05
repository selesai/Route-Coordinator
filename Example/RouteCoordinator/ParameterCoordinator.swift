//
//  ParameterCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class ParameterCoordinator: RouteCoordinator {
    
    static var path: String { RouteConstant.parameter }
    
    required init(parameter: [String : Any]?, completion: ((Result<Data, Error>) -> Void)?) {
        super.init(parameter: parameter, completion: completion)
        
        if let parameter = parameter {
            print(parameter)
        } else {
            print("No parameter provided")
        }
    }
    
    private func makeViewController() -> ParameterViewController {
        let viewController = ParameterViewController.create()
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
