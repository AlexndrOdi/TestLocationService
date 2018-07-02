//
//  SettingsPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SettingsPresenterProtocol: SettingsViewOutputProtocol, SettingsInteractorOutputProtocol {

}

class SettingsPresenter: SettingsPresenterProtocol {

    // MARK: - Properties
    weak var view: SettingsViewInputProtocol?
    var interactor: SettingsInteractorInputProtocol?

    var settings: [Preset] = []

    // MARK: - Functions
    func updateSettings(accuracy: LocationManager.Accuracy, distance: LocationManager.DistanceFilter) {
        interactor?.updateLocationSettings(accuracy: accuracy, distance: distance)
    }

    func performSettings() {
        interactor?.fetchSettings({ (settings) in
            self.settings = settings
            view?.displayAvailableSettings(settings)
        })
    }

    func changeStateOfSettingBy(index: Int) {
        interactor?.changeSettingsOfLocationManager(index: index)
    }

    func updateButtonState(array: [Preset]) {
        view?.displayUpdatedButton(array: array)
    }
}
