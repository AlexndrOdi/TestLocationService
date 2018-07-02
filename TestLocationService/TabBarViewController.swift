//
//  TabBarViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    // MARK: - Private functions
    private func setupControllers() {

        let debugController = DebugViewController()
        let debugMenuController = UINavigationController(rootViewController: debugController)
        let mapController = MapViewController()
        let settigsController = UINavigationController(rootViewController: SettingsViewController())

        let mode: UIImageRenderingMode = .alwaysOriginal
        let mapTabBarItem = UITabBarItem(title: Consts.NavigationTitle.map.rawValue,
                                         image: UIImage(named: "normalMap")?.withRenderingMode(mode),
                                         selectedImage: UIImage(named: "selectedMap")?.withRenderingMode(mode))
        let debugTabBarItem = UITabBarItem(title: Consts.NavigationTitle.debug.rawValue,
                                           image: UIImage(named: "normalDebug")?.withRenderingMode(.alwaysOriginal),
                                           selectedImage: UIImage(named: "selectedDebug")?.withRenderingMode(mode))
        let settingsTabBarItem = UITabBarItem(title: Consts.NavigationTitle.settings.rawValue,
                                              image: UIImage(named: "normalSettings")?.withRenderingMode(mode),
                                              selectedImage: UIImage(named: "selectedSettings")?.withRenderingMode(mode))

        mapController.tabBarItem = mapTabBarItem
        debugMenuController.tabBarItem = debugTabBarItem
        settigsController.tabBarItem = settingsTabBarItem

        setViewControllers([mapController, debugMenuController, settigsController], animated: true)
    }
}
