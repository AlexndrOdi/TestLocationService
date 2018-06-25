//
//  DebugInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DebugInteractorInputProtocol: class {
    
}
protocol DebugInteractorOutputProtocol: class {
    
}

class DebugInteractor: DebugInteractorInputProtocol {
    
    weak var presenter: DebugInteractorOutputProtocol?
    
    
}
