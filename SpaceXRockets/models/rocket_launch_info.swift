//
//  rocket_launch_info.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 07.06.2022.
//

import Foundation

public struct RocketLaunchInfo : Decodable{
    let rocket : String
    let name : String
    let date_utc : String?
    let success : Bool?
}
