//
//  DescriptionInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DescriptionInteractorInputProtocol: class {
    func fetchAllInformation(complition: @escaping ([Battery]) -> ())
    func fetchInformationByTimer()
}
protocol DescriptionInteractorOutputProtocol: class {
    func provideAllInformationByTimer(array: [Battery])
}

class DescriptionInteractor: DescriptionInteractorInputProtocol {
    
    weak var presenter: DescriptionInteractorOutputProtocol?
    
    var infoBatteryArray: [Battery] = []
    var lastFetchedData = Set<BatteryHistory>()
    
    var dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        return formater
    }()
    
    func fetchAllInformation(complition: @escaping ([Battery]) -> ()) {
        DispatchQueue.main.async {
            DeviceManager.sharedInstance.currentBatteryCharge(complition: { (charge) in
                
                let formattedDate = self.dateFormater.string(from: Date())
                let formattedCharge = String(describing: (charge * 100)) + "%"
                self.infoBatteryArray.append(Battery(date: formattedDate, charge: formattedCharge))
            })
            complition(self.infoBatteryArray)
        }
    }
    
    func fetchInformationByTimer() {
        let fetchedData = DeviceManager.sharedInstance.allHistoryBatteryUsage()
        let subtrack = fetchedData.subtracting(self.lastFetchedData)
        subtrack.forEach({ (item) in
            let date = self.dateFormater.string(from: item.date)
            let charge = String(describing: item.charge * 100) + "%"
            self.infoBatteryArray.append(Battery(date: date, charge: charge))
        })
        self.lastFetchedData = fetchedData
        self.presenter?.provideAllInformationByTimer(array: self.infoBatteryArray.sorted(by: { $0.date < $1.date }))
    }
    
}
