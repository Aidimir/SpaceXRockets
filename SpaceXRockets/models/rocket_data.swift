//
//  rocket_data.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

//import Foundation
//
//struct RocketData{
//    var name : String //name
//    var firstLaunch : String //first_flight
//    var country : String //country
//    var launchCost : String //cost_per_launch
//    var allLaunches : [String : [String:String]]
//    var firstStage : [String : String] //first_stage
//    var secondStage : [String : String] //second_stage
//    var height : Dictionary<String,String> //height
//    var diameter : Dictionary<String,String> //diameter
//    var mass : Dictionary<String,String> //mass
//    var pressure : Dictionary<String,String>  //lb
//    var images : Array<String>
//}

import Foundation
import CoreData

public class RocketData : NSObject, NSSecureCoding{
    public static var supportsSecureCoding = false
    enum Key: String{
        case name = "name"
        case firstLaunch = "firstLaunch"
        case country = "country"
        case launchCost = "launchCost"
        case allLaunches = "allLaunches"
        case firstStage = "firstStage"
        case secondStage = "secondStage"
        case height = "height"
        case diameter = "diameter"
        case mass = "mass"
        case pressure = "pressure"
        case images = "images"
    }
    var name : String //name
    var firstLaunch : String //first_flight
    var country : String //country
    var launchCost : String //cost_per_launch
    var allLaunches : [String : [String:String]]
    var firstStage : [String : String] //first_stage
    var secondStage : [String : String] //second_stage
    var height : [String:String] //height
    var diameter : [String:String] //diameter
    var mass : [String:String] //mass
    var pressure : [String:String]  //lb
    var images : [String]
    init(name : String, firstLaunch : String ,  country : String, launchCost : String , allLaunches : [String : [String:String]] , firstStage : [String : String] ,secondStage : [String : String] , height : Dictionary<String,String> , diameter : Dictionary<String,String>, mass : Dictionary<String,String> , pressure : Dictionary<String,String> , images : Array<String>){
        self.name = name
        self.firstLaunch = firstLaunch
        self.country = country
        self.launchCost = launchCost
        self.allLaunches = allLaunches
        self.firstStage = firstStage
        self.secondStage = secondStage
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.pressure = pressure
        self.images = images
    }
    public required convenience init?(coder: NSCoder) {
        let mname = coder.decodeObject(forKey: Key.name.rawValue) as! String
        let mfirstLaunch = coder.decodeObject(forKey: Key.firstLaunch.rawValue) as! String
        let mcountry = coder.decodeObject(forKey: Key.country.rawValue) as! String
        let mlaunchCost = coder.decodeObject(forKey: Key.launchCost.rawValue) as! String
        let mallLaunches = coder.decodeObject(forKey: Key.allLaunches.rawValue) as! [String:[String:String]]
        let mfirstStage = coder.decodeObject(forKey: Key.firstStage.rawValue) as! [String:String]
        let msecondStage = coder.decodeObject(forKey: Key.secondStage.rawValue) as! [String:String]
        let mheight = coder.decodeObject(forKey: Key.height.rawValue) as! [String:String]
        let mdiameter = coder.decodeObject(forKey: Key.diameter.rawValue) as! [String:String]
        let mmass = coder.decodeObject(forKey: Key.mass.rawValue) as! [String:String]
        let mpressure = coder.decodeObject(forKey: Key.pressure.rawValue) as! [String:String]
        let mimages = coder.decodeObject(forKey: Key.images.rawValue) as! [String]
        self.init(name: mname , firstLaunch: mfirstLaunch , country: mcountry, launchCost: mlaunchCost, allLaunches: mallLaunches , firstStage: mfirstStage , secondStage: msecondStage , height: mheight , diameter: mdiameter , mass: mmass , pressure: mpressure , images: mimages )
    }
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Key.name.rawValue)
        coder.encode(firstLaunch , forKey: Key.firstLaunch.rawValue)
        coder.encode(country , forKey: Key.country.rawValue)
        coder.encode(launchCost , forKey: Key.launchCost.rawValue)
        coder.encode(allLaunches, forKey: Key.allLaunches.rawValue)
        coder.encode(firstStage, forKey: Key.firstStage.rawValue)
        coder.encode(secondStage, forKey: Key.secondStage.rawValue)
        coder.encode(height, forKey: Key.height.rawValue)
        coder.encode(diameter, forKey: Key.diameter.rawValue)
        coder.encode(mass, forKey: Key.mass.rawValue)
        coder.encode(pressure, forKey: Key.pressure.rawValue)
        coder.encode(images, forKey: Key.images.rawValue)
    }
}

//
//  rocket_data.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

//import Foundation
//
//struct RocketData{
//    var name : String //name
//    var firstLaunch : String //first_flight
//    var country : String //country
//    var launchCost : String //cost_per_launch
//    var allLaunches : [String : [String:String]]
//    var firstStage : [String : String] //first_stage
//    var secondStage : [String : String] //second_stage
//    var height : Dictionary<String,String> //height
//    var diameter : Dictionary<String,String> //diameter
//    var mass : Dictionary<String,String> //mass
//    var pressure : Dictionary<String,String>  //lb
//    var images : Array<String>
//}

//import Foundation
//import CoreData
//import Alamofire
//
//public class RocketData : NSObject{
//    var name : String //name
//    var firstLaunch : String //first_flight
//    var country : String //country
//    var launchCost : String //cost_per_launch
//    var allLaunches : [String : [String:String]]
//    var firstStage : [String : String] //first_stage
//    var secondStage : [String : String] //second_stage
//    var height : Dictionary<String,String> //height
//    var diameter : Dictionary<String,String> //diameter
//    var mass : Dictionary<String,String> //mass
//    var pressure : Dictionary<String,String>  //lb
//    var images : Array<String>
//    init(name : String, firstLaunch : String ,  country : String, launchCost : String , allLaunches : [String : [String:String]] , firstStage : [String : String] ,secondStage : [String : String] , height : Dictionary<String,String> , diameter : Dictionary<String,String>, mass : Dictionary<String,String> , pressure : Dictionary<String,String> , images : Array<String>){
//        self.name = name
//        self.firstLaunch = firstLaunch
//        self.country = country
//        self.launchCost = launchCost
//        self.allLaunches = allLaunches
//        self.firstStage = firstStage
//        self.secondStage = secondStage
//        self.height = height
//        self.diameter = diameter
//        self.mass = mass
//        self.pressure = pressure
//        self.images = images
//    }
//
//}
