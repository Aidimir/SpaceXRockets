//
//  default_units.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation

enum cellsEnum : String {
    case mass = "Масса"
    case height = "Высота"
    case diameter = "Диаметр"
    case payloadWeights = "Полезная нагрузка"
}

public class Settings{
    public static let shared = Settings()
    var massParameter = ParameterUnits(parameterName: cellsEnum.mass.rawValue, primaryUnit: "kg", secondaryUnit: "lb")
    var heightParameter = ParameterUnits(parameterName: cellsEnum.height.rawValue, primaryUnit: "m", secondaryUnit: "feet")
    var diameterParameter = ParameterUnits(parameterName: cellsEnum.diameter.rawValue, primaryUnit: "m", secondaryUnit: "feet")
    var payloadWeightsParameter = ParameterUnits(parameterName: cellsEnum.payloadWeights.rawValue, primaryUnit: "kg", secondaryUnit: "lb")
}

// А может ну его нахер ?
