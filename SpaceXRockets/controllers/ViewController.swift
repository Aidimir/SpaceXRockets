//
//  ViewController.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let bottomController = BottomSheetController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(bottomController)
        view.addSubview(bottomController.view)
        bottomController.didMove(toParent: self)
        bottomController.view.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
}
