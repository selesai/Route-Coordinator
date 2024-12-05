//
//  DecodeParameterCoordinator.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import RouteCoordinator

class DecodeParameterCoordinator: RouteCoordinator {
    
    static var path: String { RouteConstant.decodeParameter }
    
    private func makeViewController() -> DecodeParameterViewController {
        
        let decodedParameter = try? self.transform(to: RouteDataValue.self).get()
        let title = decodedParameter?.title
        
        let viewController = DecodeParameterViewController.create(with: title)
        return viewController
    }
    
    func route() {
        let viewController = makeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DecodeParameterCoordinator {
    struct RouteDataValue: Decodable {
        let title: String?
    }
}
