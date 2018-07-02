//
//  DebugConfigurer.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class DebugConfigurer {

    // MARK: - Properties
    static let sharedInstance = DebugConfigurer()

    // MARK: - Functions
    func configure(view: DebugViewController) {
        let presenter = DebugPresenter()
        let interactor = DebugInteractor()
        let router = DebugRouter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.presenter = presenter

        router.view = view

    }
}
