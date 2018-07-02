//
//  Consts.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

struct Consts {
    // MARK: - APIKeys
    enum APIKeys: String {
        case googleMaps = "AIzaSyBYYhsn7nRypQHSszeGTIPLbrgYsw81uME"
    }
    // MARK: - Degress
    enum LocationDegrees: Double {
        case longitude = 30.277974
        case latitude = 59.942934
    }
    // MARK: - Settings name
    enum SettingNames: String {
        case accuracy = "Точность"
        case delay = "Таймер"
    }

    struct Buttons {
        // MARK: - Buttons names
        enum Text: String {
            case done = "Готово"
            case cancel = "Отмена"
        }
        // MARK: - Buttons images
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
    // MARK: - NavigationBar titles
    enum NavigationTitle: String {
        case map = "Карта"
        case debug = "Debug"
        case settings = "Настройки"
    }
    // TODO: - switch with actual
    enum DebugButtons: String {
        case battary = "Расход батареи"
        case location = "Локации"
        case numberOfReqests = "Количество запросов в минуту"
        case something = "Что-то еще"
    }
}
