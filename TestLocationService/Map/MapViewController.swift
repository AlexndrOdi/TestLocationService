//
//  MapViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol MapLogicOutputProtocol: class {
    func performMapView()
    func tappedIncreasesButton()
    func tappedDecreasesButton()
    func tappedMonitoringButton()
}

protocol MapLogicInputProtocol: class {
    func displayUserLocation(zoom: Float, cameraPosition: GMSCameraPosition)
    func displayZoom(_ zoom: Float)
}

class MapViewController: UIViewController, MapLogicInputProtocol {

    var presenter: MapLogicOutputProtocol?
    
    //Views
    //--------------------------------------------------
    let increaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Consts.Buttons.Image.increase.draw(), for: .normal)
        button.backgroundColor = UIColor.white
        button.showsTouchWhenHighlighted = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    let decreaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Consts.Buttons.Image.decrease.draw(), for: .normal)
        button.backgroundColor = UIColor.white
        button.showsTouchWhenHighlighted = true
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var monitoringButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Consts.Buttons.Image.monitoringNavigation.draw(), for: .normal)
        button.backgroundColor = UIColor.purple
        button.showsTouchWhenHighlighted = true
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    var mapView: GMSMapView = {
        GMSServices.provideAPIKey(Consts.APIKeys.GoogleMaps.rawValue)
        let view = GMSMapView()
        view.mapType = .normal
        view.settings.myLocationButton = true
        view.settings.zoomGestures = true
        view.isMyLocationEnabled = true
        view.setMinZoom(kGMSMinZoomLevel, maxZoom: 20)
        return view
    }()
    //--------------------------------------------------

    private func initMapView(){
        increaseButton.addTarget(self, action: #selector(tappedIncreaseButton), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(tappedDecreasesButton), for: .touchUpInside)
        monitoringButton.addTarget(self, action: #selector(startMonitoringUserLocation), for: .touchUpInside)
        
        verticalStack.addArrangedSubview(increaseButton)
        verticalStack.addArrangedSubview(decreaseButton)
        mapView.addSubview(verticalStack)
        mapView.addSubview(monitoringButton)
        
        let centerY = NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal, toItem: mapView, attribute: .centerY, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: verticalStack, attribute: .trailing, relatedBy: .equal, toItem: mapView, attribute: .trailing, multiplier: 1, constant: -16)
        
        let leftMonitor = NSLayoutConstraint(item: monitoringButton, attribute: .leading, relatedBy: .equal, toItem: mapView, attribute: .leading, multiplier: 1, constant: 16)
        let bottomMonitor = NSLayoutConstraint(item: monitoringButton, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1, constant: -80)
        
        mapView.addConstraints([centerY, right,
                                leftMonitor, bottomMonitor])
    
        self.view = mapView
    }
    @objc private func startMonitoringUserLocation() {
        presenter?.tappedMonitoringButton()
    }
    
    @objc private func tappedIncreaseButton() {
        presenter?.tappedIncreasesButton()
    }
    @objc private func tappedDecreasesButton() {
        presenter?.tappedDecreasesButton()
    }
    func displayZoom(_ zoom: Float) {
        mapView.animate(toZoom: zoom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapConfigurer.sharedInstance.configure(view: self)
        navigationItem.title = Consts.NavigationTitle.Map.rawValue
        mapView.delegate = self
        initMapView()
        
        presenter?.performMapView()
    }
    
    func displayUserLocation(zoom: Float, cameraPosition: GMSCameraPosition) {
        mapView.animate(to: cameraPosition)
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}
