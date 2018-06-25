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
    
    var accuracyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = UIColor.purple
        return switcher
    }()
    
    private func setup() {
        
        verticalStack.addArrangedSubview(accuracyLabel)
        verticalStack.addArrangedSubview(distanceLabel)
        addSubview(verticalStack)
        addSubview(switcher)
        
        let stackLeft = NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let stackCenterY = NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
   
        let rightSwitcher = NSLayoutConstraint(item: switcher, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16)
        let centerYSwitcher = NSLayoutConstraint(item: switcher, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        addConstraints([stackLeft, stackCenterY,
                        rightSwitcher, centerYSwitcher])
        
        selectionStyle = .none
    }
    
}
extension PresetCell: ReuseIdentifierProtocol {
    
}
