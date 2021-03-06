//
//  Preset.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 02.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

struct Preset {
    var accuracyName: String
    var distanceName: String
    var accuracy: LocationManager.Accuracy
    var distance: LocationManager.DistanceFilter
    var isActive: Bool
}
