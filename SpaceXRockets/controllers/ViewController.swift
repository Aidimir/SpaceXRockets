//
//  ViewController.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import UIKit
import SnapKit
import UBottomSheet
import Kingfisher
class ViewController: UIViewController, UserPresenterDelegate{
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    let massiveView = UIView()
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    func presentRockets(rocketsDict: [String : RocketData]) {
        var pages = [RocketPageController]()
        for i in rocketsDict{
            let rocketPage : RocketPageController = {
                var rocket = RocketPageController()
                rocket.rocket = rocketsDict[i.key]
                rocket.view.frame = view.frame
                addChild(rocket)
                rocket.didMove(toParent: self)
                return rocket
            }()
            pages.append(rocketPage)
        }
        for i in pages{
            stackView.addArrangedSubview(i.view)
        }
        massiveView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(massiveView)
        }
        scrollView.addSubview(massiveView)
        massiveView.snp.makeConstraints { make in
            make.top.left.bottom.height.right.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(pages.count)
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.width.height.equalToSuperview()
        }
    }
    let presenter = Presenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.fetchData()
    }
}
