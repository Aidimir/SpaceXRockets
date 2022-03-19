//
//  bottom_sheet_presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation
import UIKit

protocol BottomSheetDelegate{
    func presentConstructor(cellArray : [BottomScrollViewCell], header : UILabel)
}
class BottomSheetPresenter {
    weak var delegate : (BottomSheetDelegate & UIViewController)?
    func setDelegate(delegate : (BottomSheetDelegate & UIViewController)){
        self.delegate = delegate
    }
    func createCells(data : RocketData, header : UILabel){
        let heightCell = BottomScrollViewCell(value: data.height, parameterName: cellsEnum.height.rawValue)
        let diameterCell = BottomScrollViewCell(value: data.diameter, parameterName: cellsEnum.diameter.rawValue)
        let massCell = BottomScrollViewCell(value: data.mass, parameterName: cellsEnum.mass.rawValue)
        let pressureCell = BottomScrollViewCell(value: data.pressure, parameterName: cellsEnum.pressure.rawValue)
        var array = [heightCell,diameterCell,massCell,pressureCell]
        self.delegate?.presentConstructor(cellArray: array, header: header)
    }
    func createHeader(data : RocketData){
        let header : UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 40)
            label.textAlignment = .left
            label.text = data.name
            return label
        }()
        self.createCells(data: data, header: header)
    }
    func createRocketBottomSheet(data : RocketData){
        createHeader(data: data)
    }
}
