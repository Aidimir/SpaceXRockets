//
//  units_parameter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 07.06.2022.
//

import Foundation

class ParameterUnits{
    var parameterName : String
    var primaryUnit : String
    var secondaryUnit : String
    func ChangeUnits(){
        let buffer = primaryUnit
        primaryUnit = secondaryUnit
        secondaryUnit = buffer
    }
    init(parameterName : String, primaryUnit : String, secondaryUnit : String){
        self.parameterName = parameterName
        self.primaryUnit = primaryUnit
        self.secondaryUnit = secondaryUnit
    }
}
