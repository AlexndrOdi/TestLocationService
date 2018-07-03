//
//  DescriptionInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DescriptionInteractorInputProtocol: class {
    func fetchInformation()
}
protocol DescriptionInteractorOutputProtocol: class {
    func provideAllInformation(_ array: [Consumption])
}

class DescriptionInteractor: DescriptionInteractorInputProtocol {
    // MARK: - Properties
    weak var presenter: DescriptionInteractorOutputProtocol?

    var consumptions: [Consumption] = []

    // MARK: - Functions
    func fetchInformation() {
        DispatchQueue.main.async {
            let charts = DataManager.sharedInstance.fetchAllCharts()
            charts.forEach { (chart) in
                if let maxTime = chart.history.max(by: { x, y in x.time < y.time })?.time,
                    let minTime = chart.history.min(by: { x, y in x.time < y.time })?.time,
                    let maxCharge = chart.history.max(by: { x, y in x.charge < y.charge })?.charge,
                    let minCharge = chart.history.min(by: { x, y in x.charge < y.charge })?.charge {
                        let consTime = maxTime - minTime
                        let consCharge = maxCharge - minCharge
                        self.consumptions.append(Consumption(preset: chart.preset,
                                                             time: consTime, charge: consCharge * 100))
                }
            }
            self.presenter?.provideAllInformation(self.consumptions)
        }
    }
}
