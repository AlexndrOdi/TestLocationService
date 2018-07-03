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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    var accuracyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    var distanceFilterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    var verticalStackRight: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    var verticalStackLeft: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    // MARK: - Functions
    func update(_ item: Consumption) {
        dateLabel.text = "За \(item.time.description) сек"
        descriptionLabel.text = "Расход батареи \(item.charge.description) %"
        accuracyName.text = "Точность: \(item.preset.accuracyName)"
        distanceFilterName.text = "Дистанция: \(item.preset.distanceName)"
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(dateLabel)
        addSubview(descriptionLabel)

        verticalStackRight.addArrangedSubview(accuracyName)
        verticalStackRight.addArrangedSubview(distanceFilterName)

        verticalStackLeft.addArrangedSubview(dateLabel)
        verticalStackLeft.addArrangedSubview(descriptionLabel)

        addSubview(verticalStackRight)
        addSubview(verticalStackLeft)

        let centerYStackLeft = NSLayoutConstraint(item: verticalStackLeft, attribute: .centerY, relatedBy: .equal,
                                                  toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let leftStackLeft = NSLayoutConstraint(item: verticalStackLeft, attribute: .leading, relatedBy: .equal,
                                               toItem: self, attribute: .leading, multiplier: 1, constant: 8)
        let centerYStackRight = NSLayoutConstraint(item: verticalStackRight, attribute: .centerY, relatedBy: .equal,
                                         toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let rightStackRight = NSLayoutConstraint(item: verticalStackRight, attribute: .trailing, relatedBy: .equal,
                                       toItem: self, attribute: .trailing, multiplier: 1, constant: -8)
        addConstraints([centerYStackLeft, leftStackLeft,
                        centerYStackRight, rightStackRight])

        isUserInteractionEnabled = false
    }
}

extension DescriptionCell: ReuseIdentifierProtocol {

}
