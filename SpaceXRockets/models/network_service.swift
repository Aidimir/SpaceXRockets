//
//  network_data.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import Alamofire

class NetworkService {
    func getData(_ completionHandler : @escaping (Array<RocketData>?)-> Void){
        let rocketDataRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
        let rocketLaunchesRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
        let loadingGroup = DispatchGroup()
        var jsonRocketsData : Data?
        var jsonLaunchData : Data?
        AF.request(rocketDataRequest).response { response in
            if response.error == nil{
                jsonRocketsData = response.data
                AF.request(rocketLaunchesRequest).response{ response in
                    if response.error == nil{
                        jsonLaunchData = response.data
                        let allLaunches = self.fetchAllLaunches(data: jsonLaunchData!)
                        let allRockets = self.fetchAllRockets(launches: allLaunches, data: jsonRocketsData!)
                        completionHandler(allRockets)
                        // not nil
                    }
                    else{
                        completionHandler(nil)
                    }
                }
            }
            else { completionHandler(nil)}
        }
    }
    private func fetchAllLaunches(data : Data) -> [String : [RocketLaunchInfo]]{
        let allInfo : [RocketLaunchInfo] = try! JSONDecoder().decode([RocketLaunchInfo].self, from: data)
        var res = [String : [RocketLaunchInfo]]()
        for i in allInfo{
            res[i.name] != nil ? (res[i.name]?.append(i)) : (res[i.name] = [i])
        }
        return res
    }
    private func fetchAllRockets(launches : [String : [RocketLaunchInfo]], data : Data) -> [RocketData]{
        var res = [RocketData]()
        var allRockets : [RocketData] = try! JSONDecoder().decode([RocketData].self, from: data)
        for i in 0..<allRockets.count {
            allRockets[i].launchesInfo = launches[allRockets[i].id]
            res.append(allRockets[i])
        }
        res.sorted {$0.name < $1.name}
        return res
    }
}
