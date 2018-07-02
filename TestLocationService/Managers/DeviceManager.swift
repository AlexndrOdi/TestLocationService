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
    func allHistoryBatteryUsage() -> Set<BatteryHistory>
}

class DeviceManager: DeviceManagerProtocol {

    // MARK: - Properties
    static let sharedInstance = DeviceManager()

    var manager: UIDevice
    var batteryHistory = Set<BatteryHistory>()

    private var batteryLevel: Float
    private var startDate: Date

    // MARK: - Init
    private init() {
        self.manager = UIDevice.current
        self.manager.isBatteryMonitoringEnabled = true
        self.batteryHistory = []
        self.batteryLevel = 0
        self.startDate = Date()
    }

    // MARK: - Functions
    func allHistoryBatteryUsage() -> Set<BatteryHistory> {
        return batteryHistory
    }

    func resetStartTime() {
        startDate = Date()
    }

    func startMonitoringBatteryLevel() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addHistory),
                                               name: .UIDeviceBatteryLevelDidChange, object: nil)
    }

    // MARK: Private functions
    @objc private func addHistory() {
        let endDate = Date().timeIntervalSince(startDate)
        batteryHistory.update(with: BatteryHistory(time: Int(endDate), charge: manager.batteryLevel))
        print("----------------------------")
        print("update battery level = \(manager.batteryLevel)")
        print("----------------------------")
        let sortedHistory = batteryHistory.sorted(by: { $1.charge > $0.charge })
        if let last = sortedHistory.last?.charge, let first = sortedHistory.first?.charge {
            if last - first >= 0.01 {
                DataManager.sharedInstance.saveHistory(sortedHistory)
            }
        }
    }
}
