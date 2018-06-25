//
//  DebugModels.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

struct Battery {
    var date: String
    var charge: String
}

struct BatteryHistory: Hashable {
    var date: Date
    var charge: Float
}

struct Location {
    var date: String
    var position: String
}
