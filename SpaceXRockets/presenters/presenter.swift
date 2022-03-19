//
//  presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
protocol UserPresenterDelegate {
    func presentRockets(rocketsDict : [String : RocketData])
}
typealias PresenterDelegate = UserPresenterDelegate & UIViewController
class Presenter {
    weak var delegate : PresenterDelegate?
    func fetchData(){
        if rocketsDictionary.isEmpty{
            NetworkService().getData { [weak self] dict in
                self?.delegate?.presentRockets(rocketsDict: dict)
            }
        }
        else{
            delegate?.presentRockets(rocketsDict: rocketsDictionary)
        }
    }
    func setDelegate(delegate : PresenterDelegate){
        self.delegate = delegate
    }
}
