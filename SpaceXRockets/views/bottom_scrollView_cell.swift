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
    var parameterName : String
    var value : Dictionary<String,Double>
    private var valueLabel : UILabel = {
        var valueLabel = UILabel()
        valueLabel.font = .boldSystemFont(ofSize: 22)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.minimumScaleFactor = 1
        valueLabel.adjustsFontSizeToFitWidth = true
        return valueLabel
    }()
    private var unitsLabel : UILabel = {
        var unitsLabel = UILabel()
        unitsLabel.font = .systemFont(ofSize: 14)
        unitsLabel.adjustsFontSizeToFitWidth = true
        unitsLabel.textColor = .white
        unitsLabel.minimumScaleFactor = 1
        unitsLabel.textAlignment = .center
        return unitsLabel
    }()
    let view = UIView()
    func createCell(){
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
            view.backgroundColor = .gray
            view.layer.cornerRadius = 40
            make.centerX.centerY.equalTo(self)
            make.height.equalTo(self).dividedBy(1.2)
            make.width.equalTo(self).dividedBy(1.1)
        }
    }
    init(value : [String:Double], parameterName : String){
        self.value = value
        self.parameterName = parameterName
        super.init(frame: .zero)
        valueLabel.text = removeUselessZero(num: value[defaultUnits[parameterName]!]!)
        unitsLabel.text = parameterName + ", " + defaultUnits[parameterName]!
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: NSNotification.Name("updateCellLabels"), object: nil)
        createCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func updateLabels(notification : NSNotification){
        valueLabel.text = removeUselessZero(num: value[defaultUnits[parameterName]!]!)
        unitsLabel.text = parameterName + ", " + defaultUnits[parameterName]!
    }
}
