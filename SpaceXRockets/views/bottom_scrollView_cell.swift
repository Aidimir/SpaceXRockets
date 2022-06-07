//
//  bottom_scrollView_cell.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SnapKit

class BottomScrollViewCell : UIView{
    private let parameter : ParameterUnits
    private let value : Dictionary<String,Double>
    private var valueLabel : UILabel = {
        var valueLabel = UILabel()
        valueLabel.font = .boldSystemFont(ofSize: 22)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        return valueLabel
    }()
    private var unitsLabel : UILabel = {
        var unitsLabel = UILabel()
        unitsLabel.font = .systemFont(ofSize: 18)
        unitsLabel.adjustsFontSizeToFitWidth = true
        unitsLabel.textColor = UIColor(red: 0.142, green: 0.142, blue: 0.143, alpha: 1)
        unitsLabel.textAlignment = .center
        return unitsLabel
    }()
    private let view = UIView()
    private func createCell(){
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).dividedBy(1.05)
            make.height.equalTo(view).dividedBy(2)
        }
        view.addSubview(unitsLabel)
        unitsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(valueLabel).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).dividedBy(1.05)
        }
        addSubview(view)
        view.snp.makeConstraints { make in
            view.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.7)
            view.layer.cornerRadius = 30
            make.centerX.centerY.equalTo(self)
            make.height.equalTo(self).dividedBy(1.2)
            make.width.equalTo(self).dividedBy(1.1)
        }
    }
    init(value : [String:Double], parameter : ParameterUnits){
        self.value = value
        self.parameter = parameter
        super.init(frame: .zero)
        valueLabel.text = String(value[parameter.primaryUnit]!)
        unitsLabel.text = parameter.parameterName + ", " + parameter.primaryUnit
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: NSNotification.Name("updateCellLabels"), object: nil)
        createCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func updateLabels(notification : NSNotification){
        valueLabel.text = String(value[parameter.primaryUnit]!)
        unitsLabel.text = parameter.parameterName + ", " + parameter.primaryUnit
    }
}
