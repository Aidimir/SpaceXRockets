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
    public var rocket : RocketData?
    private let launchesController = LaunchesPageController()
    private func construct() {
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
        let firstStageLabelStack = createStageLabels(stageInfo: rocket?.first_stage, stageName: "первая ступень")
        let secondStageLabelStack = createStageLabels(stageInfo: rocket?.second_stage, stageName: "вторая ступень")
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
            make.width.equalToSuperview().dividedBy(9)
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
        showAllButton.layer.masksToBounds = true
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
    }
    public var sheetCoordinator: UBottomSheetCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(extremleCloseSheet), name: NSNotification.Name("closeSheet"), object: nil)
        view.backgroundColor = .black
        launchesController.modalPresentationStyle = .fullScreen
        launchesController.allRocketLaunches = rocket?.launchesInfo
        launchesController.name = rocket?.name
        if rocket != nil{
            construct()
            sheetCoordinator?.startTracking(item: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.setPosition(view.frame.maxY/1.25, animated: false)
        sheetCoordinator?.startTracking(item: self)
    }
    
    func draggableView() -> UIScrollView? {
        return scroll
    }
    
    private func createCells(data : RocketData) -> [BottomScrollViewCell]{
        let settings = Settings.shared
        let heightCell = BottomScrollViewCell(value: [settings.heightParameter.primaryUnit : data.height.meters, settings.heightParameter.secondaryUnit : data.height.feet], parameter: settings.heightParameter)
        let diameterCell = BottomScrollViewCell(value: [settings.diameterParameter.primaryUnit : data.diameter.meters, settings.diameterParameter.secondaryUnit : data.diameter.feet], parameter: settings.diameterParameter)
        let massCell = BottomScrollViewCell(value: [settings.massParameter.primaryUnit : Double(data.mass.kg), settings.massParameter.secondaryUnit : Double(data.mass.lb)], parameter: settings.massParameter)
        let payloadWeightsCell = BottomScrollViewCell(value: [settings.payloadWeightsParameter.primaryUnit : Double(data.payload_weights[0].lb ?? -1), settings.payloadWeightsParameter.secondaryUnit : Double(data.payload_weights[0].kg ?? -1)], parameter: settings.massParameter)
        let array = [heightCell,diameterCell,massCell,payloadWeightsCell]
        return array
    }
    
    private func createLabel(name : String, data : String) -> UIStackView{
        let nameLabel : UILabel = {
            let nameLabel = UILabel()
            nameLabel.font = .systemFont(ofSize: 20)
            nameLabel.textColor = UIColor(red: 0.202, green: 0.202, blue: 0.202, alpha: 1)
            nameLabel.textAlignment = .left
            nameLabel.text = name
            nameLabel.adjustsFontSizeToFitWidth = true
            return nameLabel
        }()
        let dataLabel : UILabel = {
            let dataLabel = UILabel()
            dataLabel.font = .boldSystemFont(ofSize: 20)
            dataLabel.textColor = .white
            dataLabel.textAlignment = .right
            dataLabel.text = data
            dataLabel.adjustsFontSizeToFitWidth = true
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
    
    private func createStageLabels(stageInfo : RocketData.Stage?, stageName : String)-> UIStackView{
        let header : UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .left
            label.font = .boldSystemFont(ofSize: 40)
            label.text = stageName
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        if let stageInfo = stageInfo {
            let nilLabel = createLabel(name: "информация", data: "отсутствует")
            let stack : UIStackView = {
                let stack = UIStackView(arrangedSubviews: [nilLabel])
                stack.axis = .vertical
                stack.distribution = .fillEqually
                return stack
            }()
            return stack
        }
        else{
            let enginesLabel = createLabel(name: "Количество двигателей", data: String((stageInfo?.engines!)!))
            let fuelLabel = createLabel(name: "Количество топлива", data: String((stageInfo?.fuel_amount_tons!)!) + " ton")
            let timeLabel = createLabel(name: "Время сгорания", data: String((stageInfo?.burn_time_sec!)!) + " sec")
            let stack : UIStackView = {
                let stack = UIStackView(arrangedSubviews: [header,enginesLabel,fuelLabel,timeLabel])
                stack.axis = .vertical
                stack.distribution = .fillEqually
                return stack
            }()
            return stack}
    }
    
    private func createNoNameStack(data : RocketData) -> UIStackView{
        let label0 = createLabel(name: "Первый запуск", data: rocket!.first_flight!)
        let label1 = createLabel(name: "Страна", data: rocket!.country)
        if let launchCost = rocket?.cost_per_launch{
            let message = "$" + String(removeUselessZero(num: Double(launchCost) / 1000000)) + " млн"
            let label2 = createLabel(name: "Стоимость запуска", data: message)
            let noNameLabelStack : UIStackView = {
                let stack = UIStackView(arrangedSubviews: [label0,label1,label2])
                stack.distribution = .fillEqually
                stack.axis = .vertical
                return stack
            }()
            return noNameLabelStack
        }
        else{
            let message = "неизвестно"
            let label2 = createLabel(name: "Стоимость запуска", data: message)
            let noNameLabelStack : UIStackView = {
                let stack = UIStackView(arrangedSubviews: [label0,label1,label2])
                stack.distribution = .fillEqually
                stack.axis = .vertical
                return stack
            }()
            return noNameLabelStack
        }
    }
    private func createButton()-> UIButton{
        let button = UIButton()
        button.addTarget(self, action: #selector(showAllLaunches), for: .touchUpInside)
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
            make.center.width.height.equalTo(button)
        }
        return button
    }
    @objc private func onTap(){
        present(SettingPageController(), animated: true, completion: nil)
    }
    @objc private func showAllLaunches(){
        present(launchesController,animated: true,completion: nil)
    }
    private func createSettingsButton() -> UIButton{
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
    @objc private func extremleCloseSheet(){
        if UIApplication.shared.statusBarOrientation == .landscapeLeft{
            sheetCoordinator?.setPosition(view.frame.minY/1.25, animated: false)
        }
        else{
            sheetCoordinator?.setPosition(view.frame.maxY/1.25, animated: false)
        }
    }
}
