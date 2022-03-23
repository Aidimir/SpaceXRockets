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
    func getData(_ completionHandler : @escaping (Dictionary<String,JSON>?)-> Void){
        let rocketDataRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
        let rocketLaunchesRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
        let loadingGroup = DispatchGroup()
        var jsonData = JSON()
        var jsonLaunchData = JSON()
        AF.request(rocketDataRequest).response { response in
            if response.error == nil{
                jsonData = JSON(response.data)
                AF.request(rocketLaunchesRequest).response{ response in
                    if response.error == nil{
                    jsonLaunchData = JSON(response.data)
                    var dict = ["rockets" : jsonData , "launches" : jsonLaunchData]
                    completionHandler(dict)
                    }
                    else{
                        completionHandler(nil)
                    }
                }
            }
            else { completionHandler(nil)}
        }
    }
}
