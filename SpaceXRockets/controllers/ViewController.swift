//
//  ViewController.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import UIKit
import SnapKit
import UBottomSheet

class ViewController: UIViewController {
    
    let bottomController = BottomSheetController()
    override func viewDidLoad() {
        super.viewDidLoad()
        var sheet = UBottomSheetCoordinator(parent: self, delegate: nil)
        bottomController.sheetCoordinator = sheet
        sheet.addSheet(bottomController, to: self)
    }
}
