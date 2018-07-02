//
//  NSUIColor + extensions.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 01.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

extension UIColor {
    func colorBy(value: Int) -> UIColor {
        if value < 5 {
            return UIColor.red
        }
        if value < 10 {
            return UIColor.green
        }
        if value < 20 {
            return UIColor.yellow
        }
        if value < 35 {
            return UIColor.orange
        }
        if value < 50 {
            return UIColor.purple
        }
        if value < 60 {
            return UIColor.cyan
        }
        return UIColor.blue
    }
}
