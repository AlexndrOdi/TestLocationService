//
//  DescriptionConfigurer.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class DescriptionConfigurer {
    
    static let sharedInstance = DescriptionConfigurer()
    
    func configure(view: DescriptionTableViewController) {
        let presenter = DescriptionPresenter()
        let interactor = DescriptionInteractor()
                
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
    }
}
