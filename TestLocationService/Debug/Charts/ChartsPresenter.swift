//
//  ChartsPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import Charts

protocol ChartsPresenterProtocol: ChartsViewOutputProtocol, ChartsInteractorOutputProtocol, ChartViewDelegate {

}

class ChartsPresenter: ChartsPresenterProtocol {

    // MARK: - Properties
    weak var view: ChartsViewInputProtocol?
    var interactor: ChartsInteractorInputProtocol?

    // MARK: - Functions
    func performAllCharts() {
        interactor?.fetchAllCharts()
    }

    func provideAllCharts(_ consumptions: [Consumption]) {
        view?.displayAllCharts(consumptions)
    }
}
extension ChartsPresenter {
    // MARK: - ChartViewDelegate functions
}
