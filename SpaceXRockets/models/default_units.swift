//
//  default_units.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation

var defaultUnits = ["Масса" : "kg", "Высота" : "m", "Диаметр" : "m", "Полезная нагрузка" : "kg"]
enum cellsEnum : String {
    case mass = "Масса"
    case height = "Высота"
    case diameter = "Диаметр"
    case pressure = "Полезная нагрузка"
}
var rocketsDictionary = [String: RocketData]()
var allUnits = ["Масса" : ["kg", "lb"], "Высота" : ["m","ft"], "Диаметр" : ["m","ft"], "Полезная нагрузка" : ["kg", "lb"]]
