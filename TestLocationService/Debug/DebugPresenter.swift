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
    
    weak var view: DebugViewInputProtocol?
    var interactor: DebugInteractorInputProtocol?
    var router: DebugRouterProtocol?
    
    func navigateToDebugDetail() {
        router?.navigateToDebugDetail()
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        router?.passDataToNextScene(segue: segue)
    }
}
