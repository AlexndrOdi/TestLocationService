//
//  DataManager.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 25.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class DataManager {

    // MARK: Properties
    static let sharedInstance = DataManager()

//    private var history: []

    // MARK: - 10 meters
    private var settings: [Preset] = [Preset(accuracyName: "лучшая",
                                     distanceName: "10 метров",
                                     accuracy: .best,
                                     distance: .tenMeters,
                                     isActive: true),
                              Preset(accuracyName: "для навигации",
                                     distanceName: "10 метров",
                                     accuracy: .bestForNavigation,
                                     distance: .tenMeters,
                                     isActive: false),
                              Preset(accuracyName: "около 10 метров",
                                     distanceName: "10 метров",
                                     accuracy: .nearestTenMeters,
                                     distance: .tenMeters,
                                     isActive: false),
                              Preset(accuracyName: "100 метров",
                                     distanceName: "10 метров",
                                     accuracy: .hundredMeters,
                                     distance: .tenMeters,
                                     isActive: false),
                              Preset(accuracyName: "1 киллометр",
                                     distanceName: "10 метров",
                                     accuracy: .killometer,
                                     distance: .tenMeters,
                                     isActive: false),
                              Preset(accuracyName: "3 киллометра",
                                     distanceName: "10 метров",
                                     accuracy: .threeKillometers,
                                     distance: .tenMeters,
                                     isActive: false),
                              // MARK: - 100 meters
                              Preset(accuracyName: "лучшая",
                                     distanceName: "100 метров",
                                     accuracy: .best,
                                     distance: .hundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "для навигации",
                                     distanceName: "100 метров",
                                     accuracy: .bestForNavigation,
                                     distance: .hundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "около 10 метров",
                                     distanceName: "100 метров",
                                     accuracy: .nearestTenMeters,
                                     distance: .hundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "100 метров",
                                     distanceName: "100 метров",
                                     accuracy: .hundredMeters,
                                     distance: .hundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "1 киллометр",
                                     distanceName: "100 метров",
                                     accuracy: .killometer,
                                     distance: .hundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "3 киллометра",
                                     distanceName: "100 метров",
                                     accuracy: .threeKillometers,
                                     distance: .hundredMeters,
                                     isActive: false),
                              // MARK: - 500 meters
                              Preset(accuracyName: "лучшая",
                                     distanceName: "500 метров",
                                     accuracy: .best,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "для навигации",
                                     distanceName: "50 метров",
                                     accuracy: .bestForNavigation,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "около 10 метров",
                                     distanceName: "500 метров",
                                     accuracy: .nearestTenMeters,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "100 метров",
                                     distanceName: "500 метров",
                                     accuracy: .hundredMeters,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "1 киллометр",
                                     distanceName: "500 метров",
                                     accuracy: .killometer,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              Preset(accuracyName: "3 киллометра",
                                     distanceName: "500 метров",
                                     accuracy: .threeKillometers,
                                     distance: .fiveHundredMeters,
                                     isActive: false),
                              // MARK: - 1000 meters
                              Preset(accuracyName: "лучшая",
                                     distanceName: "1000 метров",
                                     accuracy: .best,
                                     distance: .killometer,
                                     isActive: false),
                              Preset(accuracyName: "для навигации",
                                     distanceName: "1000 метров",
                                     accuracy: .bestForNavigation,
                                     distance: .killometer,
                                     isActive: false),
                              Preset(accuracyName: "около 10 метров",
                                     distanceName: "1000 метров",
                                     accuracy: .nearestTenMeters,
                                     distance: .killometer,
                                     isActive: false),
                              Preset(accuracyName: "100 метров",
                                     distanceName: "1000 метров",
                                     accuracy: .hundredMeters,
                                     distance: .killometer,
                                     isActive: false),
                              Preset(accuracyName: "1 киллометр",
                                     distanceName: "1000 метров",
                                     accuracy: .killometer,
                                     distance: .killometer,
                                     isActive: false),
                              Preset(accuracyName: "3 киллометра",
                                     distanceName: "1000 метров",
                                     accuracy: .threeKillometers,
                                     distance: .killometer,
                                     isActive: false)]

    // MARK: - Functions
    func fetchSettings() -> [Preset] {
        return settings
    }
    func saveHistory(_ history: [BatteryHistory]) {
        let (accuracy, distance) = LocationManager.sharedInstance.currentSettings()
        UserDefaults.standard.saveHistoryWithSettings(accuracy, distance, history)
        print("Data saved in memory!")
    }

    /// Remove all history from local data storage
    func clearAllHistory() {
        // TODO: ...
    }

    func fetchAllCharts() -> [Chart] {
        var result: [Chart] = []
        settings.forEach { (preset) in
            if let history = loadHistory(preset.accuracy, preset.distance) {
                result.append(Chart(preset: preset, history: history))
            }
        }
        return result
    }

    // MARK: - Private functions
    private func loadHistory(_ accuracy: LocationManager.Accuracy,
                     _ distance: LocationManager.DistanceFilter) -> [BatteryHistory]? {
        do {
            let result = try UserDefaults.standard.loadHistoryWithSettings(accuracy.setAccuracy(),
                                                              distance.setDistance())
            return result
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
