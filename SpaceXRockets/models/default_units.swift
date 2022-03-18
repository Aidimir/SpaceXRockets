//
//  default_units.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation

var defaultUnits = ["mass" : "kg", "height" : "meters", "diameter" : "meters", "pressure" : "kg"]
enum cellsEnum : String {
    case mass = "mass"
    case height = "height"
    case diameter = "diameter"
    case pressure = "pressure"
}
var rocketsDictionary = [String: RocketData]()
