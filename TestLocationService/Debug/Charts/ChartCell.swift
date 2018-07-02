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
    func updateChart(_ consumptions: [Consumption]) {
        var count: Int = 0
        let data: BarChartData = BarChartData(dataSets: [])
        DispatchQueue.main.async {
            
            consumptions.forEach({ (cons) in
                let dataEntry = BarChartDataEntry(x: Double(count), y: Double(cons.time))
                let label = "Acc: \(cons.preset.accuracyName), dist: \(cons.preset.distanceName)"
                let dataSet = BarChartDataSet(values: [dataEntry], label: label)
                dataSet.setColor(UIColor().colorBy(value: cons.time))
                data.addDataSet(dataSet)
                count += 1
            })
            data.barWidth = 1
            self.chart.data = data
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
