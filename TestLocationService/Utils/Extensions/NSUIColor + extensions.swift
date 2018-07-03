//
//  NSUIColor + extensions.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

extension UIColor {
    func colorBy(value: Float) -> UIColor {
        if value < 0.05 {
            return UIColor.red
        }
        if value < 0.07 {
            return UIColor.green
        }
        if value < 0.09 {
            return UIColor.yellow
        }
        if value < 0.11 {
            return UIColor.orange
        }
        if value < 0.13 {
            return UIColor.purple
        }
        if value < 0.16 {
            return UIColor.cyan
        }
        return UIColor.blue
    }
}
