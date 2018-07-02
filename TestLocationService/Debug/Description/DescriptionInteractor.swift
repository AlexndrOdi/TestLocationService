//
//  DescriptionInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DescriptionInteractorInputProtocol: class {
    func fetchInformationByTimer()
}
protocol DescriptionInteractorOutputProtocol: class {
    func provideAllInformationByTimer(array: [Battery], settings: (String, String))
}

class DescriptionInteractor: DescriptionInteractorInputProtocol {
    // MARK: - Properties
    weak var presenter: DescriptionInteractorOutputProtocol?

    var infoBatteryArray: [Battery] = []
    var lastFetchedData = Set<BatteryHistory>()

    // MARK: - Functions
    func fetchInformationByTimer() {
        let fetchedData = DeviceManager.sharedInstance.allHistoryBatteryUsage()
        let (acc, dist) = LocationManager.sharedInstance.currentSettings()
        let subtrack = fetchedData.subtracting(self.lastFetchedData)
        subtrack.forEach({ (item) in
            let time = String(describing: item.time) + "sec"
            let charge = String(describing: item.charge * 100) + "%"
            self.infoBatteryArray.append(Battery(date: time, charge: charge))
        })
        self.lastFetchedData = fetchedData
        self.presenter?.provideAllInformationByTimer(array: self.infoBatteryArray.sorted(by: { $0.date < $1.date }),
                                                     settings: (acc.description, dist.description))
    }
}
