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
    let imgView = UIImageView()
    let scrollView = UIScrollView()
    let bottomController = BottomSheetController()
    private var alreadyHasSheet = false
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomController.rocket = rocket
        var randomIngUrl = rocket?.images.randomElement()
        imgView.contentMode = .scaleToFill
        imgView.kf.setImage(with: URL(string: randomIngUrl!))
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onPullUp(sender: )), for: .valueChanged)
        refreshControl.tintColor = .white
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalTo(scrollView)
            make.height.equalTo(scrollView).multipliedBy(0.5)
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.top.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        if self.interfaceOrientation == .portrait{
            var sheet = UBottomSheetCoordinator(parent: self, delegate: nil)
            bottomController.sheetCoordinator = sheet
            sheet.addSheet(bottomController, to: self)
            alreadyHasSheet = true
        }
        else{
            imgView.snp.remakeConstraints { make in
                make.left.right.top.bottom.width.height.equalTo(scrollView)
            }
        }
    }
    @objc func onPullUp(sender : UIRefreshControl){
        let newRandomImage = rocket?.images.randomElement()
        imgView.kf.setImage(with: URL(string: newRandomImage!))
        sender.endRefreshing()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait{
            print("isPortrait")
            imgView.snp.remakeConstraints { make in
                make.left.right.top.bottom.width.equalTo(scrollView)
                make.height.equalTo(scrollView).multipliedBy(0.5)
            }
            if alreadyHasSheet == false{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { [self] in
                    var sheet = UBottomSheetCoordinator(parent: self, delegate: nil)
                    bottomController.sheetCoordinator = sheet
                    sheet.addSheet(bottomController, to: self)
                    alreadyHasSheet = true
                    NotificationCenter.default.post(name: NSNotification.Name("closeSheet"), object: nil)
                }
            }
        }
        else{
            print("NotPortrait")
            imgView.snp.remakeConstraints { make in
                make.left.right.top.bottom.width.height.equalTo(scrollView)
            }
            NotificationCenter.default.post(name: NSNotification.Name("closeSheet"), object: nil)
        }
    }
}
