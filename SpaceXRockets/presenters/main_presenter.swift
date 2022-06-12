//
//  presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import CoreData

protocol UserPresenterDelegate {
    func presentRockets(rocketsArray : [RocketData])
    func errorHandler()
}

protocol MainPresenterProtocol{
    func fetchData()
    func setDelegate(delegate : PresenterDelegate)
}

typealias PresenterDelegate = UserPresenterDelegate
class Presenter : MainPresenterProtocol{
    var delegate : PresenterDelegate?
    func fetchData(){
        NetworkService().getData { [weak self] allRockets in
            if allRockets != nil{
                self?.delegate?.presentRockets(rocketsArray: allRockets!)
            }
            else{
                //                //let cache = DataManager().retrieveRockets()
                //
                //                if cache != nil && cache?.isEmpty == false{
                //                    var rockets = [RocketData]()
                //                    rockets = cache![0].rockets!
                //                    print("This data fetched from cache, not internet")
                //                    self?.delegate?.presentRockets(rocketsArray: rockets)
                //                    NotificationCenter.default.post(name: NSNotification.Name("showCard"), object: String("Нет подключения к интернету, вам показана ( возможно ) устаревшая информация. Попробуйте перезагрузить приложение"))
                //                }
                //                else{
                self?.delegate?.errorHandler()
                NotificationCenter.default.post(name: NSNotification.Name("showCard"), object: String("Нет подключения к интернету, пожалуйста, повторите попытку"))
                //}
            }
        }
    }
    func setDelegate(delegate : PresenterDelegate){
        self.delegate = delegate
    }
}
