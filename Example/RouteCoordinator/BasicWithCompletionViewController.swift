//
//  BasicWithCompletionViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 23/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class BasicWithCompletionViewController: UIViewController {
    
    // MARK: - Properties
    private var coordinator: BasicWithCompletionCoordinator?
    
    // MARK: - Components
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Basic With Completion"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var successButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me for Success", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var failureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me for Failure", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    static func create(with coordinator: BasicWithCompletionCoordinator?) -> BasicWithCompletionViewController {
        let vc = BasicWithCompletionViewController()
        vc.coordinator = coordinator
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupHandler()
    }
    
    private func setupView() {
        view.addSubview(label)
        view.addSubview(stackView)
        stackView.addArrangedSubview(successButton)
        stackView.addArrangedSubview(failureButton)
        
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
            
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
        ])
    }
    
    private func setupHandler() {
        successButton.addTarget(
            self,
            action: #selector(successButtonHandler),
            for: .touchUpInside
        )
        failureButton.addTarget(
            self,
            action: #selector(failureButtonHandler),
            for: .touchUpInside
        )
    }
    
    @objc private func successButtonHandler() {
        let result = ResultData(title: "This is result data")
        
        do {
            let jsonData = try JSONEncoder().encode(result)
            self.coordinator?.completion?(
                .success(
                    jsonData
                )
            )
        } catch {
            self.coordinator?.completion?(
                .failure(
                    NSError(domain: "basic.with.completion", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to sending response"])
                )
            )
        }
    }
    
    @objc private func failureButtonHandler() {
        self.coordinator?.completion?(.failure(ResultError.justError))
    }
    
}

extension BasicWithCompletionViewController {
    struct ResultData: Encodable {
        let title: String
    }
    
    enum ResultError: Error {
        case justError
        
        var description: String {
            switch (self) {
            case .justError:
                return "Just error"
            }
        }
    }
}
