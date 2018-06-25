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
//    var deviceQueue = OperationQueue()
//    var locationQueue = OperationQueue()
    
    func assembly() {
//        locationQueue.qualityOfService = .utility
//        deviceQueue.qualityOfService = .background
//        deviceQueue.addOperation(DeviceManager.sharedInstance)
//        locationQueue.addOperation(LocationManager.sharedInstance)
        DeviceManager.sharedInstance.startMonitoringBatteryLevel()
        LocationManager.sharedInstance
        DataManager.sharedInstance
    }
    
}
