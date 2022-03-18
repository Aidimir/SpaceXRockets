//
//  usefule_methods.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation

func removeUselessZero(num : Double)-> String{
    var res = ""
    if Double(Int(num)) == num{
        res = String(Int(num))
    }
    else {
        res = String(num)
    }
    return res
}
