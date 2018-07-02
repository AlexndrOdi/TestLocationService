//
//  LocationManager.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProtocol: class {
    func updateCurrentLocation(_ location: CLLocation)
}

class LocationManager: NSObject {

    // MARK: - Properties
    static let sharedInstance = LocationManager()

    var locationManager: CLLocationManager
    var currentAccuracy: CLLocationAccuracy
    var currentDistance: CLLocationDistance

    weak var delegate: LocationProtocol?

    // MARK: - Init
    private override init() {
        self.locationManager = CLLocationManager()
        self.currentAccuracy = kCLLocationAccuracyBest
        self.currentDistance = DistanceFilter.tenMeters.setDistance()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = currentAccuracy
        self.locationManager.distanceFilter = currentDistance
    }

    // MARK: - Settings functions
    func setDistanceFilter(distance: LocationManager.DistanceFilter) {
        locationManager.distanceFilter = distance.setDistance()
    }

    func setAccuracy(accuracy: Accuracy) {
        currentAccuracy = accuracy.setAccuracy()
        locationManager.desiredAccuracy = currentAccuracy
        locationManager.startUpdatingLocation()
    }
    
    func currentSettings() -> (CLLocationAccuracy, CLLocationDistance) {
        return (locationManager.desiredAccuracy, locationManager.distanceFilter)
    }

    // MARK: - Request auth fuction
    private func enableLocationService() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            return (CLLocationManager.authorizationStatus() == .authorizedAlways ||
                CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
        case .restricted, .denied:
            //TODO: для динайда доделать
            print("Permission denied")
            return false
        default:
            return true
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    // MARK: - LocationManagerDelegate functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if enableLocationService() {
            manager.startMonitoringSignificantLocationChanges()
            manager.startUpdatingLocation()
            manager.allowsBackgroundLocationUpdates = true
        } else {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        delegate?.updateCurrentLocation(location)
        print("manager acc = \(manager.desiredAccuracy)")
        print("manager distance = \(manager.distanceFilter)")
    }
}

extension LocationManager {
    // MARK: - Accuracy enum
    enum Accuracy {
        case best, bestForNavigation, nearestTenMeters, hundredMeters, killometer, threeKillometers

        func setAccuracy() -> CLLocationAccuracy {
            switch self {
            case .best:
                return kCLLocationAccuracyBest
            case .bestForNavigation:
                return kCLLocationAccuracyBestForNavigation
            case .nearestTenMeters:
                return kCLLocationAccuracyNearestTenMeters
            case .hundredMeters:
                return kCLLocationAccuracyHundredMeters
            case .killometer:
                return kCLLocationAccuracyKilometer
            case .threeKillometers:
                return kCLLocationAccuracyThreeKilometers
            }
        }
    }

    // MARK: - DistanceFilter enum
    enum DistanceFilter {
        case tenMeters, hundredMeters, fiveHundredMeters, killometer

        func setDistance() -> CLLocationDistance {
            switch self {
            case .tenMeters:
                return 10
            case .hundredMeters:
                return 100
            case .fiveHundredMeters:
                return 500
            case .killometer:
                return 1000
            }
        }
    }
}
