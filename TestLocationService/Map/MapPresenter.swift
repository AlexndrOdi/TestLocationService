//
//  MapPresenter.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 23.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MapPresenterProtocol: MapLogicOutputProtocol, MapInteractorOutputProtocol {

}

class MapPresenter: MapPresenterProtocol {
    // MARK: - Properties
    weak var view: MapLogicInputProtocol?
    var interactor: MapInteractorInputProtocol?

    // MARK: - Functions
    func performMapView() {
        interactor?.fetchMapInfoToDisplay()
    }

    func provideLastLocation(zoom: Float, cameraPosition: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: cameraPosition.coordinate.latitude,
                                              longitude: cameraPosition.coordinate.longitude,
                                              zoom: zoom)
        view?.displayUserLocation(zoom: zoom, cameraPosition: camera)
    }

    func tappedMonitoringButton() {
        interactor?.shouldMonitoringUserLocation(complition: { (active, location) in
            if active, let loc = location {
                let camera = GMSCameraPosition.camera(withLatitude: loc.coordinate.latitude,
                                                      longitude: loc.coordinate.longitude,
                                                      zoom: 16)
                view?.displayUserLocation(zoom: 16, cameraPosition: camera)
            }
        })
    }

    func tappedIncreasesButton() {
        interactor?.increasesZoom()
    }

    func tappedDecreasesButton() {
        interactor?.decreasesZoom()
    }

    func providedZoom(_ zoom: Float) {
        view?.displayZoom(zoom)
    }
}
