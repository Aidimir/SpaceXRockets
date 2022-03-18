//
//  page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SnapKit

class BottomSheetController: UIViewController , BottomSheetDelegate {
    func presentCells(cellArray: [BottomScrollViewCell]) {
        var bottomScroll = BottomScrollView(cells: cellArray)
        print(cellArray)
        bottomScroll.backgroundColor = .black
        view.addSubview(bottomScroll)
        bottomScroll.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        bottomScroll.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * (1/6)).isActive = true
        defaultUnits["height"] = "feet"
        defaultUnits["mass"] = "lb"
        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
    }
    private let presenter = BottomSheetPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetController.panGesture))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = .black
        presenter.setDelegate(delegate: self)
        presenter.fetchData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: (0.3)) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
}
