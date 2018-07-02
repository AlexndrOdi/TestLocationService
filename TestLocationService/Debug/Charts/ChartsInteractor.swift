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
                if chart.history.count >= 15 {
                    let neededStore = chart.history[14]
                    self.consumptions.append(Consumption(preset: chart.preset,
                                                         time: neededStore.time,
                                                         charge: neededStore.charge))
                }
            })
            // TODO: доделать потом очистку
            self.presenter?.provideAllCharts(self.consumptions)
        }
    }
}
