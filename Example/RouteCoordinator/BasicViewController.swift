//
//  BasicViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Very Basic Route Coordinator"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func create() -> BasicViewController {
        let vc = BasicViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            label.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
        ])
    }
    
}
