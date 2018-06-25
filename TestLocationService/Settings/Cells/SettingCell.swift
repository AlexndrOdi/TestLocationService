//
//  SettingCell.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 20.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    enum Picker {
        case timers, settings
    }
   
    var flag: Picker?
    
    private let settings: [String] = ["Наилучшая",
                                      "Для навигации",
                                      "Около 10 метров",
                                      "100 метров",
                                      "1 киллометр",
                                      "3 киллометра"]
    private let timers: [Int] = [1,2,3,4,5,6,7,8]
    
    //default value
    var accuracySetting: LocationManager.Accuracy = .best
    var timer: Int? = 1
    var distance: Int = 50
    
    //Views
    //---------------------------------
    var picker: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var inputField: UITextField = {
        let field = UITextField()
        field.placeholder = Consts.Placeholder.defaultText.rawValue
        field.font = UIFont.boldSystemFont(ofSize: 15)
        field.textAlignment = .right
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let fieldView:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var toolBar: UIToolbar = {
        let bar = UIToolbar()
        bar.sizeToFit()
        bar.isUserInteractionEnabled = true
        return bar
    }()
    
    var settingName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        return label
    }()
    //---------------------------------
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
        inputField.delegate = self
        picker.delegate = self
        picker.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInputView(picker: Picker){
        flag = picker
    }
    
    //Private methods and setups
    private func setup() {
        inputField.inputView = picker
        
        let doneButton = UIBarButtonItem(title: Consts.Buttons.Text.done.rawValue, style: .done, target: nil, action: nil)
        toolBar.setItems([doneButton], animated: true)
        inputField.inputAccessoryView = toolBar
        
        addSubview(settingName)
        addSubview(inputField)
        addSubview(fieldView)
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": settingName]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": settingName]))

        let leftLabel = NSLayoutConstraint(item: settingName, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let topLabel = NSLayoutConstraint(item: settingName, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        let topField = NSLayoutConstraint(item: inputField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let rightField = NSLayoutConstraint(item: inputField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -50)
        
        
        let topFieldView = NSLayoutConstraint(item: fieldView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let rightFieldView = NSLayoutConstraint(item: fieldView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomFieldView = NSLayoutConstraint(item: fieldView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftFieldView = NSLayoutConstraint(item: fieldView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([leftLabel,topLabel,
                        rightField, topField,
                        topFieldView, rightFieldView, bottomFieldView, leftFieldView])
    }
}
extension SettingCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if flag == .settings {
            return settings.count
        }
        return timers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if flag == .settings {
            return settings[row]
        }
        return timers[row].description
    }
    
}
extension SettingCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if flag == .settings {
            inputField.text = settings[row]
            return
        }
        inputField.text = timers[row].description
    }
}

extension SettingCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
            switch text {
            case settings[0]:
                accuracySetting = .best
            case settings[1]:
                accuracySetting = .bestForNavigation
            case settings[2]:
                accuracySetting = .nearestTenMeters
            case settings[3]:
                accuracySetting = .hundredMeters
            case settings[4]:
                accuracySetting = .killometer
            case settings[5]:
                accuracySetting = .threeKillometers
            default:
                timer = Int(text)
        }

    }
}

extension SettingCell: ReuseIdentifierProtocol {
    
}
