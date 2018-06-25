//
//  SettingsInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol SettingsInteractorOutputProtocol: class {
    func updateButtonState(array: [Preset])
}
protocol SettingsInteractorInputProtocol: class {
    func updateLocationSettings(accuracy: LocationManager.Accuracy, distance: LocationManager.DistanceFilter)
    func fetchSettings(_ complition: ([Preset]) -> ())
    func changeSettingsOfLocationManager(index: Int)
}

class SettingsInteractor: SettingsInteractorInputProtocol {

    weak var presenter: SettingsInteractorOutputProtocol?
    var locationManager: LocationProtocol?

    //TODO: сделать нормально
    var arrayOfSettings: [Preset] = []
    
    func updateLocationSettings(accuracy: LocationManager.Accuracy, distance: LocationManager.DistanceFilter) {
        LocationManager.sharedInstance.setAccuracy(accuracy: accuracy)
        LocationManager.sharedInstance.setDistanceFilter(distance: distance)
    }
    func fetchSettings(_ complition: ([Preset]) -> ()) {
        self.arrayOfSettings = DataManager.sharedInstance.fetchSettings()
        complition(arrayOfSettings)
    }
    func changeSettingsOfLocationManager(index: Int) {
        LocationManager.sharedInstance.setAccuracy(accuracy: arrayOfSettings[index].accuracy)
        LocationManager.sharedInstance.setDistanceFilter(distance: arrayOfSettings[index].distance)
        if let itemIndex = self.arrayOfSettings.index(where: { $0.isActive == true }) {
            self.arrayOfSettings[itemIndex].isActive = false
        }
        self.arrayOfSettings[index].isActive = true
        presenter?.updateButtonState(array: arrayOfSettings)
    }
}
