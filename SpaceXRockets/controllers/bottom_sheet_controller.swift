//
//  page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SnapKit
import UBottomSheet

class BottomSheetController: UIViewController, BottomSheetDelegate,Draggable{
    var scroll = UIScrollView()
    func presentConstructor(cellArray: [BottomScrollViewCell], header: UILabel) {
        var filler = UIView()
        var bottomScroll = BottomScrollView(cells: cellArray)
        print(cellArray)
        bottomScroll.backgroundColor = .black
        filler.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.centerX.width.equalTo(filler)
            make.height.equalTo(filler).dividedBy(7)
        }
        filler.addSubview(bottomScroll)
        bottomScroll.snp.makeConstraints { make in
            make.left.right.width.equalTo(filler)
            make.top.equalTo(header.snp.bottom)
        }
        bottomScroll.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * (1/6)).isActive = true
        scroll.addSubview(filler)
        filler.snp.makeConstraints { make in
            make.top.left.right.bottom.width.equalTo(scroll)
            make.height.equalTo(scroll).multipliedBy(1.3)
        }
        view.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.bottom.height.left.right.width.equalToSuperview()
        }
//        That's how changeValues func will work
//        defaultUnits["height"] = "feet"
//        defaultUnits["mass"] = "lb"
//        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
    }
    var sheetCoordinator: UBottomSheetCoordinator?
    private let presenter = BottomSheetPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        presenter.setDelegate(delegate: self)
        presenter.fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.startTracking(item: self)
    }
    func draggableView() -> UIScrollView? {
        return scroll
    }
}
