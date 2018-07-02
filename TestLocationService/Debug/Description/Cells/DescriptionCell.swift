//
//  DescriptionCell.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Views
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    var accuracyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    var distanceFilterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    // MARK: - Functions
    func update(batteryState: Battery, settingsName: (String, String)) {
        dateLabel.text = batteryState.date
        descriptionLabel.text = batteryState.charge
        accuracyName.text = settingsName.0
        distanceFilterName.text = settingsName.1
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(dateLabel)
        addSubview(descriptionLabel)

        verticalStack.addArrangedSubview(accuracyName)
        verticalStack.addArrangedSubview(distanceFilterName)

        addSubview(verticalStack)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": dateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": dateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": descriptionLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-34-[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": descriptionLabel]))
        let centerY = NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal,
                                         toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: verticalStack, attribute: .trailing, relatedBy: .equal,
                                       toItem: self, attribute: .trailing, multiplier: 1, constant: 8)
        addConstraints([centerY, right])
        isUserInteractionEnabled = false
    }
}

extension DescriptionCell: ReuseIdentifierProtocol {

}
