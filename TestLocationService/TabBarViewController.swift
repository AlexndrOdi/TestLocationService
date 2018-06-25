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


    private func setupControllers() {

        let debugController = DebugViewController()
        let debugMenuController = UINavigationController(rootViewController: debugController)
        let mapController = MapViewController()
        let settigsController = UINavigationController(rootViewController: SettingsViewController())
        
        let mapTabBarItem = UITabBarItem(title: Consts.NavigationTitle.Map.rawValue,
                                         image: UIImage(named: "normalMap")?.withRenderingMode(.alwaysOriginal),
                                         selectedImage: UIImage(named: "selectedMap")?.withRenderingMode(.alwaysOriginal))
        let debugTabBarItem = UITabBarItem(title: Consts.NavigationTitle.Debug.rawValue,
                                           image: UIImage(named: "normalDebug")?.withRenderingMode(.alwaysOriginal),
                                           selectedImage: UIImage(named: "selectedDebug")?.withRenderingMode(.alwaysOriginal))
        let settingsTabBarItem = UITabBarItem(title: Consts.NavigationTitle.Settings.rawValue,
                                              image: UIImage(named: "normalSettings")?.withRenderingMode(.alwaysOriginal),
                                              selectedImage: UIImage(named: "selectedSettings")?.withRenderingMode(.alwaysOriginal))
        
        mapController.tabBarItem = mapTabBarItem
        debugMenuController.tabBarItem = debugTabBarItem
        settigsController.tabBarItem = settingsTabBarItem
        
        setViewControllers([mapController, debugMenuController, settigsController], animated: true)
    }
}
