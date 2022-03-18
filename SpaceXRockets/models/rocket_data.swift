//
//  rocket_data.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation

struct RocketData{
    var name : String //name
    var firstLaunch : String //first_flight
    var country : String //country
    var launchCost : Double //cost_per_launch
    var allLaunches : [String : String]
    var firstStage : [String : Double] //first_stage
    var secondStage : [String : Double] //second_stage
    var height : Dictionary<String,Double> //height
    var diameter : Dictionary<String,Double> //diameter
    var mass : Dictionary<String,Double> //mass
    var pressure : Dictionary<String,Double>  //lb
}
