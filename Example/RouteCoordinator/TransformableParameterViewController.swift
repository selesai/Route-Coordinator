//
//  TransformableParameterViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class TransformableParameterViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Route Coordinator with Transformed Parameter"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func create(with title: String?) -> TransformableParameterViewController {
        let vc = TransformableParameterViewController()
        vc.titleLabel.text = "Received title: \(title ?? "")"
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
