//
//  ChartsInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol ChartsInteractorInputProtocol: class {
    func fetchAllCharts()
}

protocol ChartsInteractorOutputProtocol: class {
    func provideAllCharts(_ consumptions: [Consumption])
}

class ChartsInteractor: ChartsInteractorInputProtocol {

    // MARK: - Properties
    weak var presenter: ChartsInteractorOutputProtocol?

    var consumptions: [Consumption] = []

    // MARK: - Functions
    func fetchAllCharts() {
        DispatchQueue.main.async {
            let charts = DataManager.sharedInstance.fetchAllCharts()
            charts.forEach({ (chart) in
                if let maxTime = chart.history.max(by: { x, y in x.time < y.time })?.time,
                    let minTime = chart.history.min(by: { x, y in x.time < y.time })?.time,
                    let maxCharge = chart.history.max(by: { x, y in x.charge < y.charge })?.charge,
                    let minCharge = chart.history.min(by: { x, y in x.charge < y.charge })?.charge {
                        let consTime = maxTime - minTime
                        let consCharge = maxCharge - minCharge
                        let averageChargeInTime = consCharge / Float(consTime)
                        self.consumptions.append(Consumption(preset: chart.preset,
                                                             time: 60, charge: averageChargeInTime * 60 * 100))
                }
            })
            self.presenter?.provideAllCharts(self.consumptions)
        }
    }
}
