//
//  DebugRouter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DebugRouterProtocol: class {
    func navigateToDebugDetail()
    func navigateToCharts()
    func passDataToNextScene(segue: UIStoryboardSegue)
}

class DebugRouter: DebugRouterProtocol {

    // MARK: - Properties
    weak var view: DebugViewController?

    // MARK: - Functions
    func navigateToDebugDetail() {
        let destinationVC = DescriptionTableViewController()
        destinationVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func navigateToCharts() {
        let destinationVC = ChartsViewController()
        destinationVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Pass data
    func passDataToNextScene(segue: UIStoryboardSegue) {
        print("pass data")
    }
}
