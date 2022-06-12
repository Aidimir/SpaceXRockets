//
//  usefule_methods.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 18.03.2022.
//

import Foundation
import SwiftUI

public class UsefulThings{
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
    func getNormalDateFormat(date : String) -> String{
        var array = [Character]()
        for i in date{
            array.append(i)
        }
        var year = ""
        for i in 0...3{
            year += String(array[i])
        }
        var month = ""
        for i in 5...6{
            month += String(array[i])
        }
        var day = ""
        for i in 8...9{
            day += String(array[i])
        }
        return String(removeUselessZero(num: Double(day)!) + " " + monthes[month]! + "," + year)
    }
    let monthes = ["01" : "января","02":"февраля","03":"марта","04":"апреля","05":"мая","06":"июня","07":"июля","08":"августа","09":"сентября","10":"октября","11":"ноября","12":"декабря"]
    // Мне было очень лень прописывать все потенциально возможные страны, или же использовать google translater API для всего двух стран во всем JSON-е
    let countries = ["Republic of the Marshall Islands" : "Республика Маршалловы Острова", "United States" : "США"]

}
