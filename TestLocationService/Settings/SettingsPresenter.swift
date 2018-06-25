//
//  SettingsPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol: SettingsViewOutputProtocol, SettingsInteractorOutputProtocol {
    
}

class SettingsPresenter: SettingsPresenterProtocol {
 
    weak var view: SettingsViewInputProtocol?
    var interactor: SettingsInteractorInputProtocol?

    func updateSettings(accuracy: LocationManager.Accuracy?, timer: Int?) {
        interactor?.updateLocationSettings(accuracy: accuracy, timer: timer)
    }
}
