//
//  switchButton_and_header.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 20.03.2022.
//

import Foundation
import UIKit
import SnapKit

class SwitchButton : UIButton{
    var parameter : String?
    func setup(){}
    @objc func onTap(){
                defaultUnits["height"] = "feet"
                defaultUnits["mass"] = "lb"
                NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
    }
}
