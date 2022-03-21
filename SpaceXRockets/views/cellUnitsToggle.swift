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
    var parameterName : String
    var value1 : String
    var value2 : String
    let header : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let label1 : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let label2 : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let valuesStack : UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    func createButton(){
        header.text = parameterName
        label1.text = value1
        label2.text = value2
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
        if defaultUnits[parameterName] == value1{
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
    func createButtonAndHeader(){
    }
    @objc func onTap(){
        if label2.backgroundColor == UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1) {
            label2.backgroundColor = .white
            label1.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
            defaultUnits[parameterName] = value2
        }
        else{
            label1.backgroundColor = .white
            label2.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
            defaultUnits[parameterName] = value1
        }
        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
        UserDefaults.standard.setValue(defaultUnits, forKey: "values")
    }
    init(parameterName : String,value1 : String, value2 : String){
        self.parameterName = parameterName
        self.value1 = value1
        self.value2 = value2
        super.init(frame: .zero)
        createButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
