//
//  bottomSheet_presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 10.06.2022.
//

import Foundation
import UIKit

protocol BottomSheetView : AnyObject{
    func createLabel(name : String, data : String) -> UIStackView
    func createStageLabels(stageInfo : RocketData.Stage?, stageName : String)-> UIStackView
    func createNoNameStack(data : RocketData) -> UIStackView
    func createButton()-> UIButton
    func onTap()
    func extremleCloseSheet()
    func construct(cellArray : [BottomScrollViewCell])
}

protocol BottomSheetPresenterDelegate {
    func build(data : RocketData?)
}

class BottomSheetPresenter : BottomSheetPresenterDelegate{
    public weak var view : BottomSheetView?
    func build(data: RocketData?){
        if data != nil{
        let settings = Settings.shared
            let heightCell = BottomScrollViewCell(value: [settings.heightParameter.primaryUnit : data!.height.meters, settings.heightParameter.secondaryUnit : data!.height.feet], parameter: settings.heightParameter)
            let diameterCell = BottomScrollViewCell(value: [settings.diameterParameter.primaryUnit : data!.diameter.meters, settings.diameterParameter.secondaryUnit : data!.diameter.feet], parameter: settings.diameterParameter)
            let massCell = BottomScrollViewCell(value: [settings.massParameter.primaryUnit : Double(data!.mass.kg), settings.massParameter.secondaryUnit : Double(data!.mass.lb)], parameter: settings.massParameter)
            let payloadWeightsCell = BottomScrollViewCell(value: [settings.payloadWeightsParameter.primaryUnit : Double(data!.payload_weights[0].lb ?? -1), settings.payloadWeightsParameter.secondaryUnit : Double(data!.payload_weights[0].kg ?? -1)], parameter: settings.payloadWeightsParameter)
        let array = [heightCell,diameterCell,massCell,payloadWeightsCell]
        view?.construct(cellArray: array)
        }
    }
}
