//
//  presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData
protocol UserPresenterDelegate {
    func presentRockets(rocketsDict : [String : RocketData])
    func errorHandler()
}
typealias PresenterDelegate = UserPresenterDelegate & UIViewController
class Presenter {
    weak var delegate : PresenterDelegate?
    func fetchData(){
        NetworkService().getData { [weak self] dict in
            if dict != nil{
                self?.presentData(data : dict!)
            }
            else{
                let cache = DataManager().retrieveRockets()
                if cache?[0].rockets != nil{
                    var rockets = [RocketData]()
                    rockets = cache![0].rockets!
                    let dictFromArray = self?.getDictFromArray(array: rockets)
                    print("This data fetched from cache, not internet")
                    self?.delegate?.presentRockets(rocketsDict: dictFromArray!)
                }
                else{
                self?.delegate?.errorHandler()
                }
                }
        }
    }
    func setDelegate(delegate : PresenterDelegate){
        self.delegate = delegate
    }
    func presentData(data : Dictionary<String,JSON>){
        let jsonData = data["rockets"]!
        let jsonLaunchData = data["launches"]!
        var dict = [String : RocketData]()
        for i in 0..<jsonData.count{
            let name = jsonData[i]["name"].rawValue as? String ?? "нет информации"
            let firstLaunch = jsonData[i]["first_flight"].rawValue as? String ?? "нет информации"
            var country = jsonData[i]["country"].rawValue as? String ?? "нет информации"
            country = countries[country] ?? country
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
            firstStage = ifDictionaryNoData(dict: firstStage)
            secondStage = ifDictionaryNoData(dict: secondStage)
            let h = jsonData[i]["height"].rawValue as? Dictionary<String,Double> ?? ["meters" : -1, "feet" : -1]
            var height = [String:String]()
            height ["m"] = String(h["meters"] ?? -1)
            height["ft"] = String(h["feet"] ?? -1)
            height = ifDictionaryNoData(dict: height)
            let w = jsonData[i]["diameter"].rawValue as? Dictionary<String,Double> ?? ["meters" : -1, "feet" : -1]
            var width = [String:String]()
            width["m"] = String(w["meters"] ?? -1)
            width["ft"] = String(h["feet"] ?? -1)
            width = ifDictionaryNoData(dict: width)
            var m = jsonData[i]["mass"].rawValue as? Dictionary<String,Double> ?? ["kg" : -1, "lb" : -1]
            var mass = [String:String]()
            for (key,value) in m{
                mass[key] = String(value)
            }
            mass = ifDictionaryNoData(dict: mass)
            let id = jsonData[i]["id"].rawValue as! String
            var pressure = [String:String]()
            pressure["lb"] = String(jsonData[i]["payload_weights"][0]["lb"].rawValue as? Double ?? -1)
            pressure["kg"] = String(jsonData[i]["payload_weights"][0]["kg"].rawValue as? Double ?? -1)
            pressure = ifDictionaryNoData(dict: pressure)
            var images = jsonData[i]["flickr_images"].rawValue as? Array<String> ?? []
            var launchDict = fetchLaunchesInfo(launches: jsonLaunchData, rocketId: id)
            dict[id] = RocketData(name: name, firstLaunch: firstLaunch, country: country, launchCost: launchCost, allLaunches: launchDict , firstStage: firstStage, secondStage: secondStage, height: height, diameter: width, mass: mass, pressure: pressure, images: images)
        }
        DataManager().resetCoreData()
        DataManager().saveRocketsToCoreData(rockets: getArrayFromDict(dict: dict))
        let k = DataManager().retrieveRockets()
        print(k?[0].rockets)
        self.delegate?.presentRockets(rocketsDict: dict)
    }
    func ifDictionaryNoData(dict : Dictionary<String,String>) -> Dictionary<String,String>{
        var buf = dict
        for (key , value) in dict{
            if value == "-1.0"{
                buf[key] = "нет информации"
            }
            else{
                buf[key] = removeUselessZero(num: Double(value)!)
            }
        }
        return buf
    }
    func fetchLaunchesInfo(launches : JSON, rocketId : String) -> [String:[String:String]]{
        var launchDict = [String:[String:String]]()
        for i in 0..<launches.count{
            if rocketId == launches[i]["rocket"].rawValue as! String{
                let name = launches[i]["name"].rawValue as? String ?? "Нет имени"
                if launches[i]["success"].rawValue as? Bool != nil{
                    var date = launches[i]["date_utc"].rawValue as? String ?? "нет информации"
                    date = getNormalDateFormat(date: date)
                    let success = String(launches[i]["success"].rawValue as! Bool)
                    var launchData = [String:String]()
                    launchData = ["success" : success, "date" : date]
                    launchDict[name] = launchData
                }
            }
        }
        return launchDict
    }
    func getArrayFromDict(dict : [String:RocketData]) -> Array<RocketData>{
        var res = [RocketData]()
        for (_,value) in dict{
            res.append(value)
        }
        res = res.sorted(){$0.name < $1.name}
        return res
    }
    func getDictFromArray(array : Array<RocketData>) -> Dictionary<String,RocketData>{
        var res = [String:RocketData]()
        for i in array{
            res[i.name] = i
        }
        return res
    }
}
