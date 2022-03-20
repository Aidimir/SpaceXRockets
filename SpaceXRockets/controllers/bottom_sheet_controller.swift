//
//  page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SnapKit
import UBottomSheet

class BottomSheetController: UIViewController,Draggable{
    private var scroll = UIScrollView()
    var rocket : RocketData?
    func construct() {
        var cellArray = createCells(data: rocket!)
        let header : UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 40)
            label.textAlignment = .left
            label.text = rocket!.name
            return label
        }()
        let showAllButton = createButton()
        let settingsButton = createSettingsButton()
        let noNameLabelStack = createNoNameStack(data: rocket!)
        let firstStageLabelStack = createStageLabels(engines: String(rocket!.firstStage["engines"]!), fuel: String(rocket!.firstStage["fuel_amount_tons"]!), time: String(rocket!.firstStage["burn_time_sec"]!), stage: "первая ступень")
        let secondStageLabelStack = createStageLabels(engines: String(rocket!.firstStage["engines"]!), fuel: String(rocket!.firstStage["fuel_amount_tons"]!), time: String(rocket!.firstStage["burn_time_sec"]!), stage: "вторая ступень")
        var filler = UIView()
        var bottomScroll = BottomScrollView(cells: cellArray)
        bottomScroll.backgroundColor = .black
        filler.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.centerX.width.equalTo(filler)
            make.height.equalTo(filler).dividedBy(7)
        }
        filler.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.right.centerY.equalTo(header)
            make.width.equalToSuperview().dividedBy(7)
            make.height.equalToSuperview().dividedBy(25)
        }
        filler.addSubview(bottomScroll)
        bottomScroll.snp.makeConstraints { make in
            make.centerX.width.equalTo(filler)
            make.top.equalTo(header.snp.bottom)
        }
        bottomScroll.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * (1/6)).isActive = true
        filler.addSubview(noNameLabelStack)
        noNameLabelStack.snp.makeConstraints { make in
            make.centerX.equalTo(filler)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(bottomScroll.snp.bottom)
            make.height.equalToSuperview().dividedBy(6)
        }
        filler.addSubview(firstStageLabelStack)
        firstStageLabelStack.snp.makeConstraints { make in
            make.centerX.equalTo(filler)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(noNameLabelStack.snp.bottom).offset(view.frame.height/20)
            make.height.equalToSuperview().dividedBy(6)
        }
        filler.addSubview(secondStageLabelStack)
        secondStageLabelStack.snp.makeConstraints { make in
            make.centerX.equalTo(filler)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(firstStageLabelStack.snp.bottom).offset(view.frame.height/20)
            make.height.equalToSuperview().dividedBy(6)
        }
        filler.addSubview(showAllButton)
        showAllButton.snp.makeConstraints { make in
            make.centerX.equalTo(filler)
            make.bottom.equalTo(filler).inset(view.frame.height/20)
            make.height.equalToSuperview().dividedBy(15)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        scroll.addSubview(filler)
        filler.snp.makeConstraints { make in
            make.top.left.right.bottom.width.equalTo(scroll)
            make.height.equalTo(scroll).multipliedBy(1.45)
        }
        view.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.bottom.height.left.right.width.equalToSuperview()
        }
//        That's how changeValues func will work
//        defaultUnits["height"] = "feet"
//        defaultUnits["mass"] = "lb"
//        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
    }
    var sheetCoordinator: UBottomSheetCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        if rocket != nil{
            construct()
            sheetCoordinator?.startTracking(item: self)
        }
        else{}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.setPosition(view.frame.maxY/1.25, animated: false)
        sheetCoordinator?.startTracking(item: self)
    }
    
    func draggableView() -> UIScrollView? {
        return scroll
    }
    
    func createCells(data : RocketData) -> [BottomScrollViewCell]{
        let heightCell = BottomScrollViewCell(value: data.height, parameterName: cellsEnum.height.rawValue)
        let diameterCell = BottomScrollViewCell(value: data.diameter, parameterName: cellsEnum.diameter.rawValue)
        let massCell = BottomScrollViewCell(value: data.mass, parameterName: cellsEnum.mass.rawValue)
        let pressureCell = BottomScrollViewCell(value: data.pressure, parameterName: cellsEnum.pressure.rawValue)
        var array = [heightCell,diameterCell,massCell,pressureCell]
        return array
    }
    
    func createLabel(name : String, data : String) -> UIStackView{
        let nameLabel : UILabel = {
           let nameLabel = UILabel()
            nameLabel.font = .systemFont(ofSize: 20)
            nameLabel.textColor = UIColor(red: 0.202, green: 0.202, blue: 0.202, alpha: 1)
            nameLabel.textAlignment = .left
            nameLabel.text = name
            return nameLabel
        }()
        let dataLabel : UILabel = {
            let dataLabel = UILabel()
            dataLabel.font = .boldSystemFont(ofSize: 20)
            dataLabel.textColor = .white
            dataLabel.textAlignment = .right
            dataLabel.text = data
            return dataLabel
     }()
        
        let stack : UIStackView = {
           let stack = UIStackView(arrangedSubviews: [nameLabel,dataLabel])
            stack.axis = .horizontal
            stack.distribution = .fillProportionally
            return stack
        }()
        return stack
    }
    
    func createStageLabels(engines : String, fuel: String, time : String, stage : String)-> UIStackView{
        let header : UILabel = {
           let label = UILabel()
            label.textColor = .white
            label.textAlignment = .left
            label.font = .boldSystemFont(ofSize: 40)
            label.text = stage
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        
        let enginesLabel = createLabel(name: "Количество двигателей", data: engines)
        let fuelLabel = createLabel(name: "Количество топлива", data: fuel + " ton")
        let timeLabel = createLabel(name: "Время сгорания", data: time + " sec")
        let stack : UIStackView = {
           let stack = UIStackView(arrangedSubviews: [header,enginesLabel,fuelLabel,timeLabel])
            stack.axis = .vertical
            stack.distribution = .fillEqually
            return stack
        }()
        return stack
    }
    
    func createNoNameStack(data : RocketData) -> UIStackView{
        let label0 = createLabel(name: "Первый запуск", data: rocket!.firstLaunch)
        let label1 = createLabel(name: "Страна", data: rocket!.country)
        let label2 = createLabel(name: "Стоимость запуска", data: "$" + String(Double(rocket!.launchCost)!  / 100) + " млн")
        let noNameLabelStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [label0,label1,label2])
            stack.distribution = .fillEqually
            stack.axis = .vertical
            return stack
        }()
        return noNameLabelStack
    }
    
    func createButton()-> UIButton{
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.5)
        button.layer.cornerRadius = 15
        let label : UILabel = {
            let label = UILabel()
            label.text = "Посмотреть все запуски"
            label.font = .boldSystemFont(ofSize: 30)
            label.textColor = .white
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(button)
        }
        return button
    }
    
    @objc func onTap(){
        print("tapped")
    }
    func createSettingsButton() -> UIButton{
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        let imgView = UIImageView(image: UIImage(systemName: "gearshape"))
        imgView.tintColor = .white
        button.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.center.width.height.equalTo(button)
        }
        return button
    }
}
