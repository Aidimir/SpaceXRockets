//
//  rocket_page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 19.03.2022.
//

import UIKit
import SnapKit
import UBottomSheet
import Kingfisher

class RocketPageController: UIViewController{
    var rocket : RocketData?
    let bottomController = BottomSheetController()
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomController.rocket = rocket
        var randomIngUrl = rocket?.images.randomElement()
        var imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.kf.setImage(with: URL(string: randomIngUrl!))
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalToSuperview()
        }
        var sheet = UBottomSheetCoordinator(parent: self, delegate: nil)
        bottomController.sheetCoordinator = sheet
        sheet.addSheet(bottomController, to: self)
    }
}
