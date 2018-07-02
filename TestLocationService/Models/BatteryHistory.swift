//
//  BatteryHistory.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 02.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class BatteryHistory: NSObject, NSCoding {
    
    // MARK: - Property keys
    struct PropertyKeys {
        static let time = "date"
        static let charge = "charge"
    }
    
    // MARK: - Encoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKeys.time)
        aCoder.encode(charge, forKey: PropertyKeys.charge)
    }
    
    // MARK: - Decoding
    required convenience init?(coder aDecoder: NSCoder) {
        if aDecoder.containsValue(forKey: PropertyKeys.time) &&
            aDecoder.containsValue(forKey: PropertyKeys.charge) {
            let time = aDecoder.decodeInteger(forKey: PropertyKeys.time)
            let charge = aDecoder.decodeFloat(forKey: PropertyKeys.charge)
            self.init(time: time, charge: charge)
        } else {
            return nil
        }
    }
    
    // MARK: - Properties
    var time: Int
    var charge: Float
    
    // MARK: - Init
    init(time: Int, charge: Float) {
        self.time = time
        self.charge = charge
    }
}
