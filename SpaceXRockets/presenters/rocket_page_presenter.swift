//
//  rocket_page_presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 12.06.2022.
//

import Foundation
import UIKit

protocol RocketPageView : AnyObject{
    func onPullUp(sender : UIRefreshControl,newImage : String)
}

class RocketPagePresenter {
    public weak var view : RocketPageView?
    private var rocket : RocketData
    public func onPullUp(){
        let newRandomImage = rocket.flickr_images!.randomElement()
        view?.onPullUp(sender: 
    }
    init(rocket : RocketData){
        self.rocket = rocket
    }
}
