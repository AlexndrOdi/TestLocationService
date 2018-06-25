//
//  DescriptionPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DescriptionPresenterProtocol: DescriptionInteractorOutputProtocol, DescriptionViewOutputProtocol {
    
}

class DescriptionPresenter: DescriptionPresenterProtocol {
    
    weak var view: DescriptionViewInputProtocol?
    var interactor: DescriptionInteractorInputProtocol?
    
    func prepareInformation() {
        interactor?.fetchInformationByTimer()
        startUpdateTableByTimer()
    }
    
    func provideAllInformationByTimer(array: [Battery]) {
        view?.displayInformation(info: array)
    }
    
    private func startUpdateTableByTimer() {
        Timer.scheduledTimer(timeInterval: Consts.Timer.Battery.everyMin.rawValue,
                             target: self,
                             selector: #selector(update),
                             userInfo: nil,
                             repeats: true)
    }
    @objc private func update(){
        interactor?.fetchInformationByTimer()
    }
}
