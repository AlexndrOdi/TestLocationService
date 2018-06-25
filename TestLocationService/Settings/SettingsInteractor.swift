//
//  SettingsInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol SettingsInteractorOutputProtocol: class {
    
}
protocol SettingsInteractorInputProtocol: class {
    func updateLocationSettings(accuracy: LocationManager.Accuracy?, timer: Int?)
}

class SettingsInteractor: SettingsInteractorInputProtocol {

    weak var presenter: SettingsInteractorOutputProtocol?
    var locationManager: LocationProtocol?

    func updateLocationSettings(accuracy: LocationManager.Accuracy?, timer: Int?) {
        if let acc = accuracy {
            LocationManager.sharedInstance.setAccuracy(accuracy: acc)
        }
        if let updateTimer = timer {
            LocationManager.sharedInstance.setUpdateTimer(timer: updateTimer)
        }
    }
}
