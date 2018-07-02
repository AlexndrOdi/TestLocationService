//
//  UserDefaults + extensions.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import CoreLocation

extension UserDefaults {
    func saveHistoryWithSettings(_ accuracy: CLLocationAccuracy,
                      _ distance: CLLocationDistance,
                      _ history: [BatteryHistory]) {
        let saveKey = accuracy.description + distance.description
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: history)
        set(encodedData, forKey: saveKey)
        synchronize()
    }

    func loadHistoryWithSettings(_ accuracy: CLLocationAccuracy,
                                 _ distance: CLLocationDistance) throws -> [BatteryHistory] {
        let loadKey = accuracy.description + distance.description
        guard let decodedData: Data = UserDefaults.standard.data(forKey: loadKey) else {
            throw DecodingDataError.keyNotFound
        }
        guard let history = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [BatteryHistory] else {
            throw NSKeyedUnarchiverError.unsuccessfulCast
        }
        return history
    }
}
