//
//  DeviceManager.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

//Not used
protocol DeviceManagerProtocol: class {
    func currentBatteryCharge(complition: (Float) -> ())
    func allHistoryBatteryUsage() -> Set<BatteryHistory>
}

class DeviceManager: DeviceManagerProtocol {
    
    static let sharedInstance = DeviceManager()
        
    var manager: UIDevice
    var batteryHistory = Set<BatteryHistory>()
    
    private var batteryLevel: Float
    
    private init() {
        self.manager = UIDevice.current
        self.manager.isBatteryMonitoringEnabled = true
        self.batteryHistory = []
        self.batteryLevel = 0
    }
    
    func currentBatteryCharge(complition: (Float) -> ()) {
        batteryLevel = manager.batteryLevel
        complition(batteryLevel)
    }
    
    func allHistoryBatteryUsage() -> Set<BatteryHistory> {
        return batteryHistory
    }
    
    func startMonitoringBatteryLevel() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addHistory),
                                               name: .UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    @objc private func addHistory(){
        batteryHistory.update(with: BatteryHistory(date: Date(), charge: manager.batteryLevel))
        print("----------------------------")
        print("update battery level = \(manager.batteryLevel)")
        print("----------------------------")
    }
}
