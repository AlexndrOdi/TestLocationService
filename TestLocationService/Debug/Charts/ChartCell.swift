//
//  ChartCell.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 30.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit
import Charts

class ChartCell: UITableViewCell {

    // MARK: - Properties
    let data: BarChartData = BarChartData(dataSets: [])

    // MARK: - Views
    var chart: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.legend.xEntrySpace = 40
        view.legend.form = .circle
        view.legend.formSize = 10
        view.legend.horizontalAlignment = .left
        view.legend.verticalAlignment = .bottom
        return view
    }()

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func updateChart(_ consumption: Consumption) {
        DispatchQueue.main.async {
            let dataEntry = BarChartDataEntry(x: Double(consumption.time), y: Double(consumption.charge))
            let label = "Acc: \(consumption.preset.accuracyName), dist: \(consumption.preset.distanceName)"
            let dataSet = BarChartDataSet(values: [dataEntry], label: label)
            dataSet.setColor(UIColor().colorBy(value: consumption.charge))
            self.data.addDataSet(dataSet)
            self.data.barWidth = 2
            self.chart.data = self.data
        }
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(chart)

        chart.maxVisibleCount = 30

        chart.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chart.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        chart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        chart.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
extension ChartCell: ReuseIdentifierProtocol {

}
