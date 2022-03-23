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
    var launchCost : String //cost_per_launch
    var allLaunches : [String : [String:String]]
    var firstStage : [String : String] //first_stage
    var secondStage : [String : String] //second_stage
    var height : Dictionary<String,String> //height
    var diameter : Dictionary<String,String> //diameter
    var mass : Dictionary<String,String> //mass
    var pressure : Dictionary<String,String>  //lb
    var images : Array<String>
}
