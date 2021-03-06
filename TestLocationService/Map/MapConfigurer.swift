//
//  MapConfigurer.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class MapConfigurer {

    // MARK: - Properties
    static let sharedInstance = MapConfigurer()

    // MARK: - Functions
    func configure(view: MapViewController) {

        let presenter = MapPresenter()
        let interactor = MapInteractor()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor

        interactor.presenter = presenter
    }
}
