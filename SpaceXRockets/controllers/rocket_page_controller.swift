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
        var imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: "https://cdn.vox-cdn.com/thumbor/ryEjFL0uh-30k5okWpVPDF1uLjU=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/23285493/51914370605_ac04ae277b_k.jpg"))
        view.addSubview(imgView)
        imgView.frame = view.frame
        var sheet = UBottomSheetCoordinator(parent: self, delegate: nil)
        bottomController.sheetCoordinator = sheet
        sheet.addSheet(bottomController, to: self)
    }
}
