//
//  Assambler.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class Assambler {

    static let sharedInstance = Assambler()

    func assembly() {
        DeviceManager.sharedInstance.startMonitoringBatteryLevel()
    }

}
