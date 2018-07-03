//
//  DescriptionPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DescriptionPresenterProtocol: DescriptionInteractorOutputProtocol, DescriptionViewOutputProtocol {

}

class DescriptionPresenter: DescriptionPresenterProtocol {

    // MARK: - Properties
    weak var view: DescriptionViewInputProtocol?
    var interactor: DescriptionInteractorInputProtocol?

    // MARK: - Functions
    func prepareInformation() {
        interactor?.fetchInformation()
    }

    func provideAllInformation(_ array: [Consumption]) {
        view?.displayInformation(array)
    }
    // MARK: - Private functions

}
