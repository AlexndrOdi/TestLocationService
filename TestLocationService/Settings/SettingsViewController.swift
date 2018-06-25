//
//  SettingsViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SettingsViewOutputProtocol: class {
    func updateSettings(accuracy: LocationManager.Accuracy?, timer: Int?)
}
protocol SettingsViewInputProtocol: class {
    
}

class SettingsViewController: UITableViewController, SettingsViewInputProtocol {
    
    var presenter: SettingsViewOutputProtocol?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SettingsConfigurer.sharedInstance.configure(view: self)
        
        self.navigationItem.title = Consts.NavigationTitle.Settings.rawValue
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        tableView.register(PresetCell.self, forCellReuseIdentifier: PresetCell.identifier)
    }
    
    @objc func dismissPicker() {
        guard let index = selectedIndexPath else { return }
        guard let cell = tableView.cellForRow(at: index) as? SettingCell else { return }
        cell.inputField.endEditing(true)
    
        presenter?.updateSettings(accuracy: cell.accuracySetting, timer: cell.timer)
    }
    
    //TableView dataSource and delegate
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            let left = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
            let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            view.addSubview(label)
            view.addConstraints([left, centerY])
            return view
        }()
        if let label = footerView.subviews.first as? UILabel, section == 1 {
            label.text = "Presets:"
        }
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier) as? SettingCell else {
            fatalError("The dequeued cell is not an instance of SettingCell")
        }
        guard let cellPreset = tableView.dequeueReusableCell(withIdentifier: PresetCell.identifier) as? PresetCell else {
            fatalError("The dequeued cell is not an instance of SettingCell")
        }
        
        if indexPath.section == 0 {
            cell.settingName.text = Consts.SettingNames.accuracy.rawValue
            cell.setInputView(picker: .settings)
            if let button = cell.toolBar.items?.first {
                button.target = self
                button.action = #selector(dismissPicker)
            }
            //TODO: disabled to tests
            cell.isUserInteractionEnabled = false
            return cell
        }
        if indexPath.section == 1 {
            cell.settingName.text = Consts.SettingNames.delay.rawValue
            cell.setInputView(picker: .timers)
            if let button = cell.toolBar.items?.first {
                button.target = self
                button.action = #selector(dismissPicker)
            }
            //TODO: disabled to tests
            cell.isUserInteractionEnabled = false
            return cell
        }
        
        cellPreset.nameLabel.text = "Preset \(indexPath.section - 1)"
        
        return cellPreset
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingCell {
            cell.inputField.becomeFirstResponder()
            selectedIndexPath = indexPath
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
