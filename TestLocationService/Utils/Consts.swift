//
//  Consts.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

enum Consts {
    enum APIKeys: String {
        case GoogleMaps = "AIzaSyBYYhsn7nRypQHSszeGTIPLbrgYsw81uME"
    }
    enum LocationDegrees: Double {
        case longitude = 30.277974
        case latitude = 59.942934
    }
    
    enum SettingNames: String {
        case accuracy = "Точность"
        case delay = "Таймер"
    }
    enum Buttons {
        enum Text: String {
            case done = "Готово"
            case cancel = "Отмена"
        }
        enum Image {
            case increase, decrease, monitoringNavigation
            func draw() -> UIImage {
                switch self {
                case .increase:
                    return UIImage(named: "plus")!
                case .decrease:
                    return UIImage(named: "minus")!
                case .monitoringNavigation:
                    return UIImage(named: "navigation")!
                }
            }
        }
    }
    enum Placeholder: String {
        case defaultText = "По умолчанию"
    }
    enum NavigationTitle: String {
        case Map = "Карта"
        case Debug = "Debug"
        case Settings = "Настройки"
    }
    enum DebugButtons: String {
        case battary = "Расход батареи"
        case location = "Локации"
        case numberOfReqests = "Количество запросов в минуту"
        case something = "Что-то еще"
    }
    enum Timer {
        enum Battery: Double {
            case everyHour = 3600
            case every30min = 1800
            case every10min = 600
            case every5min = 300
            case everyMin = 60
        }
    }
}

