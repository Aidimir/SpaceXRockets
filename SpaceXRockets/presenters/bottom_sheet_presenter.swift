//
//  bottom_sheet_presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation
import UIKit

protocol BottomSheetDelegate{
    func presentCells(cellArray : [BottomScrollViewCell])
}
class BottomSheetPresenter {
    weak var delegate : (BottomSheetDelegate & UIViewController)?
    func setDelegate(delegate : (BottomSheetDelegate & UIViewController)){
        self.delegate = delegate
    }
    func createCells(data : RocketData){
        let heightCell = BottomScrollViewCell(value: data.height, parameterName: cellsEnum.height.rawValue)
        let diameterCell = BottomScrollViewCell(value: data.diameter, parameterName: cellsEnum.diameter.rawValue)
        let massCell = BottomScrollViewCell(value: data.mass, parameterName: cellsEnum.mass.rawValue)
        let pressureCell = BottomScrollViewCell(value: data.pressure, parameterName: cellsEnum.pressure.rawValue)
        var array = [heightCell,diameterCell,massCell,pressureCell]
        self.delegate?.presentCells(cellArray: array)
    }
    func fetchData(){
        if rocketsDictionary.isEmpty{
            NetworkService().getData { dict in
                self.createCells(data: dict["Falcon Heavy"]!)
            }
        }
        else{
            self.createCells(data: rocketsDictionary["Falcon Heavy"]!)
        }
    }
}
