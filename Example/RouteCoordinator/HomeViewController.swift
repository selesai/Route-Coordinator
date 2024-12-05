//
//  HomeViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 12/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

//
//  HomeViewController.swift
//  RouteCoordinator_Example
//
//  Created by Marsudi Widodo on 12/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import RouteCoordinator

class HomeViewController: UITableViewController {

    @IBOutlet var cellText: UITableViewCell!

    private var actions1: [String] = []
    private var actions2: [String] = []
    private var actions3: [String] = []
    private var actions4: [String] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Route Coordinator"
        
        actions1.append("Basic")
        actions1.append("Basic Completion")
        actions1.append("Basic Completion & Parsing Response")
        
        actions2.append("Send Parameter")
        
        actions3.append("Manual Decode Parameter")
        actions3.append("Transformed Parameter")
        actions3.append("Transformed Parameter With Dictionary")
        
        actions4.append("Call Without Route Manager")
    }
}

// MARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension HomeViewController {
    
    override func numberOfSections(
        in tableView: UITableView
    ) -> Int {

        return 4
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        if (section == 0) {
            return actions1.count
        }
        
        if (section == 1) {
            return actions2.count
        }
        
        if (section == 2) {
            return actions3.count
        }
        
        if (section == 3) {
            return actions4.count
        }

        return 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            return self.tableView(
                tableView,
                cellWithText: actions1[indexPath.row]
            )
        }
        
        
        if (indexPath.section == 1) {
            return self.tableView(
                tableView,
                cellWithText: actions2[indexPath.row]
            )
        }
        
        
        if (indexPath.section == 2) {
            return self.tableView(
                tableView,
                cellWithText: actions3[indexPath.row]
            )
        }
        
        
        if (indexPath.section == 3) {
            return self.tableView(
                tableView,
                cellWithText: actions4[indexPath.row]
            )
        }

        return UITableViewCell()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellWithText text: String
    ) -> UITableViewCell {

        var cell: UITableViewCell! = tableView.dequeueReusableCell(
            withIdentifier: "cell"
        )
        if (cell == nil) {
            cell = UITableViewCell(
                style: .default,
                reuseIdentifier: "cell"
            )
        }
        cell.textLabel?.text = text

        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        
        if (section == 0) {
            return "Base"
        }
        
        if (section == 1) {
            return "Parameter"
        }
        
        if (section == 2) {
            return "Decode Parameter"
        }
        
        if (section == 3) {
            return "Others"
        }

        return nil
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController {
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                gotoBasic()
            }
            if (indexPath.row == 1) {
                gotoBasicWithCompletion()
            }
            if (indexPath.row == 2) {
                gotoBasicWithCompletionParsing()
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                gotoParameter()
            }
        }
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                gotoDecodeParameter()
            }
            if (indexPath.row == 1) {
                gotoTransformedParameter()
            }
            if (indexPath.row == 2) {
                gotoTransformedParameterWithDictionary()
            }
        }
        
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                callWithoutRouteManager()
            }
        }
    }
}

extension HomeViewController {
    private func gotoBasic() {
        RouteManager.shared.route(
            path: RouteConstant.basic,
            navigationController: navigationController
        )
    }
    
    private func gotoBasicWithCompletion() {
        RouteManager.shared.route(
            path: RouteConstant.basicWithCompletion,
            navigationController: navigationController
        ) { result in
            print(result)
        }
    }
    
    private func gotoBasicWithCompletionParsing() {
        RouteManager.shared.route(
            path: RouteConstant.basicWithCompletion,
            navigationController: navigationController
        ) { (result: Result<Response, Error>) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func gotoParameter() {
        let parameter = Parameter(title: "Parameter")
        RouteManager.shared.route(
            path: RouteConstant.parameter,
            with: parameter,
            navigationController: navigationController
        )
    }
    
    private func gotoDecodeParameter() {
        let parameter = Parameter(title: "Manual Decode Parameter")
        RouteManager.shared.route(
            path: RouteConstant.decodeParameter,
            with: parameter,
            navigationController: navigationController
        )
    }
    
    private func gotoTransformedParameter() {
        let parameter = Parameter(title: "Transformed Parameter")
        RouteManager.shared.route(
            path: RouteConstant.transformedParameter,
            with: parameter,
            navigationController: navigationController
        )
    }
    
    private func gotoTransformedParameterWithDictionary() {
        let parameter = ["title": "Transformed Parameter With Dictionary"]
        RouteManager.shared.route(
            path: RouteConstant.transformedParameter,
            with: parameter,
            navigationController: navigationController
        )
    }
    
    private func callWithoutRouteManager() {
        let parameter = ["title": "Call without Route Manager"]
        let coordinator = WithoutRouteManagerCoordinator(parameter: parameter, completion: nil)
        coordinator.navigationController = navigationController
        coordinator.route()
    }
}

extension HomeViewController {
    struct Response: RouteResponse {
        let title: String?
    }
    
    struct Parameter: RouteParameter {
        let title: String?
    }
}
