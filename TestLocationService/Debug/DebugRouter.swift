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
    func passDataToNextScene(segue: UIStoryboardSegue)
}

class DebugRouter: DebugRouterProtocol {
    
    weak var view: DebugViewController?
 
    func navigateToDebugDetail() {
        let destinationVC = DescriptionTableViewController()
        view?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        print("pass data")
    }
}
