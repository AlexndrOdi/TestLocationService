//
//  SettingsViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SettingsViewOutputProtocol: class {
    func updateSettings(accuracy: LocationManager.Accuracy, distance: LocationManager.DistanceFilter)
    func changeStateOfSettingBy(index: Int)
    func performSettings()
}
protocol SettingsViewInputProtocol: class {
    func displayAvailableSettings(_ settings: [Preset])
    func displayUpdatedButton(array: [Preset])
}

class SettingsViewController: UITableViewController, SettingsViewInputProtocol {

    // MARK: - Properties
    var presenter: SettingsViewOutputProtocol?

    var array: [Preset] = []

    // MARK: - Views
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal,
                                      toItem: view, attribute: .leading, multiplier: 1, constant: 16)
        let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                                         toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addSubview(label)
        view.addConstraints([left, centerY])
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        SettingsConfigurer.sharedInstance.configure(view: self)

        self.navigationItem.title = Consts.NavigationTitle.settings.rawValue
        tableView.register(PresetCell.self, forCellReuseIdentifier: PresetCell.identifier)
        presenter?.performSettings()
    }

    // MARK: - Functions
    func displayAvailableSettings(_ settings: [Preset]) {
        self.array = settings
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayUpdatedButton(array: [Preset]) {
        self.array = array
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Switch action
    @objc func changedStateOfSetting(_ sender: UISwitch) {
        presenter?.changeStateOfSettingBy(index: sender.tag)
    }

    // MARK: - TableView dataSource and delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PresetCell.identifier) as? PresetCell else {
            fatalError("The dequeued cell is not an instance of SettingCell")
        }
        cell.switcher.addTarget(self, action: #selector(changedStateOfSetting(_:)), for: .valueChanged)
        cell.switcher.tag = indexPath.section

        cell.update(array[indexPath.row])

        return cell
    }
}
