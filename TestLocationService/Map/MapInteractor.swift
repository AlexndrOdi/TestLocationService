//
//  MapInteractor.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import CoreLocation

protocol MapInteractorInputProtocol: class {
    func fetchMapInfoToDisplay()
    func increasesZoom()
    func decreasesZoom()
    func shouldMonitoringUserLocation(complition: (Bool, CLLocation?) -> Void)
}

protocol MapInteractorOutputProtocol: class {
    func provideLastLocation(zoom: Float, cameraPosition: CLLocation)
    func providedZoom(_ zoom: Float)
}

class MapInteractor: MapInteractorInputProtocol, LocationProtocol {

    // MARK: - Properties
    var zoomLevel: Float = 20
    var userMonitoringIsActive: Bool = false
    var userLocation: CLLocation?

    weak var presenter: MapInteractorOutputProtocol?
    var locationManager: LocationManager?

    // MARK: - Functions
    func fetchMapInfoToDisplay() {
        locationManager = LocationManager.sharedInstance
        locationManager?.delegate = self
    }

    func increasesZoom() {
        zoomLevel += 1
        presenter?.providedZoom(zoomLevel)
    }

    func decreasesZoom() {
        zoomLevel -= 1
        presenter?.providedZoom(zoomLevel)
    }

    func shouldMonitoringUserLocation(complition: (Bool, CLLocation?) -> Void) {
        guard let location = userLocation else {
            complition(false, nil)
            return
        }
        userMonitoringIsActive = !userMonitoringIsActive
        complition(userMonitoringIsActive, location)
    }

    // MARK: - Location protocol delegate functions
    func updateCurrentLocation(_ location: CLLocation) {
        userLocation = location
        if userMonitoringIsActive {
            presenter?.provideLastLocation(zoom: zoomLevel, cameraPosition: location)
        }
    }
}
