//
//  cellUnitsToggle.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 20.03.2022.
//

import Foundation
import UIKit
import SnapKit

class SettingsButton : UIView{
    private var parameter : ParameterUnits
    private let presenter = SettingsPresenter()
    private let header : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let label1 : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let label2 : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let valuesStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    private func createButton(){
        var value1 = parameter.primaryUnit
        var value2 = parameter.secondaryUnit
        var valueArray : [String] = [value1,value2]
        valueArray = valueArray.sorted{$0>$1}
        header.text = parameter.parameterName
        label1.text = valueArray[0]
        label2.text = valueArray[1]
        valuesStack.addArrangedSubview(label1)
        label1.layer.cornerRadius = 10
        label1.layer.masksToBounds = true
        valuesStack.addArrangedSubview(label2)
        label2.layer.cornerRadius = 10
        label2.layer.masksToBounds = true
        let button : UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
            return button
        }()
        if parameter.primaryUnit == valueArray[0]{
            label1.backgroundColor = .white
            label2.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        }
        else {
            label2.backgroundColor = .white
            label1.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        }
        addSubview(header)
        header.snp.makeConstraints { make in
            make.left.top.bottom.height.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        addSubview(valuesStack)
        valuesStack.snp.makeConstraints { make in
            make.right.top.bottom.height.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        addSubview(button)
        button.snp.makeConstraints { make in
            make.right.top.bottom.height.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
    }
    @objc private func onTap(){
        if label2.backgroundColor == UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1) {
            label2.backgroundColor = .white
            label1.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        }
        else{
            label1.backgroundColor = .white
            label2.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        }
        presenter.onCellsToogleTapped(parameter: parameter)

        //                parameter.ChangeUnits()
        //        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
        //        UserDefaults.standard.setValue(defaultUnits, forKey: "values")
    }
    init(parameter : ParameterUnits){
        self.parameter = parameter
        super.init(frame: .zero)
        createButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
