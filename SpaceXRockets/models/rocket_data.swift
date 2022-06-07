import Foundation
import CoreData

public struct RocketData : Decodable{
    struct Stage : Decodable{
        let engines : Int?
        let fuel_amount_tons : Double?
        let burn_time_sec : Double?
    }
    struct Height : Decodable{
        let meters : Double
        let feet : Double
    }
    struct Diameter : Decodable{
        let meters : Double
        let feet : Double
    }
    struct Mass : Decodable{
        let kg : Int
        let lb : Int
    }
    struct PayloadWeights : Decodable{
        let kg : Int?
        let lb : Int?
    }
    let name : String
    var first_flight : String? = "не запускался"
    let country : String
    let cost_per_launch : Int?
    let first_stage :  Stage?
    let second_stage : Stage?
    let height : Height
    let diameter : Diameter
    let mass : Mass
    let id : String
    var launchesInfo : [RocketLaunchInfo]?
    var flickr_images : [String]? = [""]
    var payload_weights : [PayloadWeights]
}
