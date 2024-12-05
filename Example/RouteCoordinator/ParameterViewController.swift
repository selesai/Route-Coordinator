//
//  ParameterViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class ParameterViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Route Coordinator with Parameter"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Parameter just printed\nas Dictionary see your log"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func create() -> ParameterViewController {
        let vc = ParameterViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            label.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            titleLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
        ])
    }
    
}
