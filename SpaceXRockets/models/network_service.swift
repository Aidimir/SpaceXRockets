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
    func getData(_ completionHandler : @escaping (Dictionary<String,RocketData>)-> Void){
        let rocketDataRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
        let rocketLaunchesRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
        var dict = [String : RocketData]()
        AF.request(rocketDataRequest).response { response in
            let jsonData = JSON(response.data)
            for i in 0..<jsonData.count{
                let name = jsonData[i]["name"].rawValue as! String
                let firstLaunch = jsonData[i]["first_flight"].rawValue as! String
                let country = jsonData[i]["country"].rawValue as! String
                let launchCost = jsonData[i]["cost_per_launch"].rawValue as! Double
//                let firstStage = jsonData[i]["first_stage"].rawValue as! String
                let height = jsonData[i]["height"].rawValue as! Dictionary<String,Double>
                let width = jsonData[i]["diameter"].rawValue as! Dictionary<String,Double>
                let mass = jsonData[i]["mass"].rawValue as! Dictionary<String,Double>
                var pressure = [String:Double]()
                pressure["lb"] = jsonData[i]["payload_weights"][0]["lb"].rawValue as! Double
                pressure["kg"] = jsonData[i]["payload_weights"][0]["kg"].rawValue as! Double
                var test = ["nickname" : "heavy sut" , "date" : "03 сентября 2003"]
                dict[name] = RocketData(name: name, firstLaunch: firstLaunch, country: country, launchCost: launchCost, allLaunches: test, firstStage: ["some": 0], secondStage: ["some": 1], height: height, diameter: width, mass: mass, pressure: pressure)
            }
            completionHandler(dict)
        }
    }
}
