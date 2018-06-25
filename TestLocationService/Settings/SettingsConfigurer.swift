//
//  SettingsConfigurer.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class SettingsConfigurer {
    
    static let sharedInstance = SettingsConfigurer()
    
    func configure(view: SettingsViewController) {
        
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
    }
}
