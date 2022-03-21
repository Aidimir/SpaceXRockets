//
//  network_data.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    func getData(_ completionHandler : @escaping (Dictionary<String,RocketData>?)-> Void){
        let rocketDataRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
        let rocketLaunchesRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
        var dict = [String : RocketData]()
        let loadingGroup = DispatchGroup()
        var jsonData = JSON()
        var jsonLaunchData = JSON()
        loadingGroup.enter()
        AF.request(rocketDataRequest).response { response in
            if response.error == nil{
                jsonData = JSON(response.data)
                AF.request(rocketLaunchesRequest).response{ response in
                    jsonLaunchData = JSON(response.data)
                    loadingGroup.leave()
                }
            }
            else { completionHandler(nil)}
        }
        loadingGroup.notify(queue: .main){
        for i in 0..<jsonData.count{
            let name = jsonData[i]["name"].rawValue as? String ?? "нет информации"
            let firstLaunch = jsonData[i]["first_flight"].rawValue as? String ?? "нет информации"
            let country = jsonData[i]["country"].rawValue as! String
            var launchCost = String(jsonData[i]["cost_per_launch"].rawValue as? Double ?? -1)
            if launchCost == "-1.0"{
            launchCost = "нет информации"
            }
            var firstStage = [String : String]()
            firstStage["engines"] = String(jsonData[i]["first_stage"]["engines"].rawValue as? Double ?? -1)
            firstStage["fuel_amount_tons"] = String( jsonData[i]["first_stage"]["fuel_amount_tons"].rawValue as? Double ?? -1)
            firstStage["burn_time_sec"] = String(jsonData[i]["first_stage"]["burn_time_sec"].rawValue as? Double ?? -1)
            var secondStage = [String : String]()
            secondStage["engines"] = String(jsonData[i]["second_stage"]["engines"].rawValue as? Double ?? -1)
            secondStage["fuel_amount_tons"] = String(jsonData[i]["second_stage"]["fuel_amount_tons"].rawValue as? Double ?? -1)
            secondStage["burn_time_sec"] = String(jsonData[i]["second_stage"]["burn_time_sec"].rawValue as? Double ?? -1)
            for (key,value) in firstStage{
                if value == "-1.0"{
                    firstStage[key] = "нет информации"
                }
                else{
                    firstStage[key] = removeUselessZero(num: Double(value)!)
                }
            }
            for (key,value) in secondStage{
                if value == "-1.0"{
                    secondStage[key] = "нет информации"
                }
                else{
                    firstStage[key] = removeUselessZero(num: Double(value)!)
                }
            }
            let h = jsonData[i]["height"].rawValue as! Dictionary<String,Double>
            var height = [String:Double]()
            height ["m"] = h["meters"]
            height["ft"] = h["feet"]
            let w = jsonData[i]["diameter"].rawValue as! Dictionary<String,Double>
            var width = [String:Double]()
            width["m"] = w["meters"]
            width["ft"] = w["feet"]
            let mass = jsonData[i]["mass"].rawValue as! Dictionary<String,Double>
            let id = jsonData[i]["id"].rawValue as! String
            var pressure = [String:Double]()
            pressure["lb"] = jsonData[i]["payload_weights"][0]["lb"].rawValue as! Double
            pressure["kg"] = jsonData[i]["payload_weights"][0]["kg"].rawValue as! Double
            var test = ["heavy sut" : ["date" : "03 сентября 2003"]]
            var images = jsonData[i]["flickr_images"].rawValue as! Array<String>
            var launchDict = [String:[String:Any]]()
            for i in 0..<jsonLaunchData.count{
                    if id == jsonLaunchData[i]["rocket"].rawValue as! String{
                        let name = jsonLaunchData[i]["name"].rawValue as! String
                        if jsonLaunchData[i]["success"].rawValue as? Bool != nil{
                            let date = jsonLaunchData[i]["date_utc"].rawValue as? String ?? "нет информации"
                            let success = jsonLaunchData[i]["success"].rawValue as! Bool
                            var launchData = [String:Any]()
                            launchData = ["success" : success, "date" : date]
                            launchDict[name] = launchData
                        }
                    }
                }
            dict[id] = RocketData(name: name, firstLaunch: firstLaunch, country: country, launchCost: launchCost, allLaunches: launchDict , firstStage: firstStage, secondStage: secondStage, height: height, diameter: width, mass: mass, pressure: pressure, images: images)
            print(dict[id]!.name, dict[id]!.allLaunches)
        }
            completionHandler(dict)
        }
    }
}
