//
//  DebugPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DebugPresenterProtocol: DebugViewOutputProtocol, DebugInteractorOutputProtocol {

}

class DebugPresenter: DebugPresenterProtocol {

    // MARK: - Properties
    weak var view: DebugViewInputProtocol?
    var interactor: DebugInteractorInputProtocol?
    var router: DebugRouterProtocol?

    // MARK: - Navigation functions
    func navigateToDebugDetail() {
        router?.navigateToDebugDetail()
    }

    func navigateToCharts() {
        router?.navigateToCharts()
    }

    // MARK: - Function of pass data to next scene
    func passDataToNextScene(segue: UIStoryboardSegue) {
        router?.passDataToNextScene(segue: segue)
    }
}
