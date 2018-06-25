//
//  PresetCell.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 25.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class PresetCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(switchEvent), for: .touchUpInside)
        return switcher
    }()
    
    
    @objc private func switchEvent() {
        print("changed switch position")
    }
    
    private func setup() {
        addSubview(nameLabel)
        addSubview(switcher)
        
        let labelLeft = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let labelCenterY = NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        let switcherRight = NSLayoutConstraint(item: switcher, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16)
        let switcherCenterY = NSLayoutConstraint(item: switcher, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        addConstraints([labelLeft, labelCenterY,
                        switcherRight, switcherCenterY])
    }
    
}
extension PresetCell: ReuseIdentifierProtocol {
    
}
