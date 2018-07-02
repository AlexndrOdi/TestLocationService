//
//  ChartsConfigurer.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class ChartsConfigurer {

    // MARK: - Properties
    static let sharedInstance = ChartsConfigurer()

    // MARK: - Functions
    func configure(view: ChartsViewController) {
        let presenter = ChartsPresenter()
        let interactor = ChartsInteractor()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor

        interactor.presenter = presenter
    }
}
