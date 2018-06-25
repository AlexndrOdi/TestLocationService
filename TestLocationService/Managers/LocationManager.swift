//
//  LocationManager.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProtocol {
    func updateCurrentLocation(_ location: CLLocation)
//    func requestLocation(_ completion: (CLLocation?) -> ())
//    func setUpdateTimer(timer: Int)
//    func setAccuracy(accuracy: LocationManager.Accuracy)
}

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    
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
    
    var locationManager: CLLocationManager
    var currentAccuracy: CLLocationAccuracy
    
    var timeInteravel: Double
    
    var delegate: LocationProtocol?
    
    private override init() {
        self.locationManager = CLLocationManager()
        self.currentAccuracy = kCLLocationAccuracyBest
        self.timeInteravel = 10
        super.init()
        self.locationManager.delegate = self
    }
    
    func setUpdateTimer(timer: Int){
        self.timeInteravel = Double(timer)
    }
    
    func setAccuracy(accuracy: Accuracy){
        locationManager.delegate = self
        currentAccuracy = accuracy.setAccuracy()
        locationManager.desiredAccuracy = currentAccuracy
        locationManager.startUpdatingLocation()
    }
    
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
    }
}
