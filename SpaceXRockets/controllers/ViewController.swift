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
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    let spinner = UIActivityIndicatorView()
    private let massiveView = UIView()
    private let stackView : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    func errorHandler() {
        let errorImgView = UIImageView(image: UIImage(named: "errorImage"))
        spinner.removeFromSuperview()
        errorImgView.frame = view.frame
        view.addSubview(errorImgView)
    }
    func presentRockets(rocketsDict: [String : RocketData]) {
        spinner.removeFromSuperview()
        var pages = [RocketPageController]()
        for i in rocketsDict.sorted{$0.0 < $1.0}{
            let rocketPage : RocketPageController = {
                let rocket = RocketPageController()
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
        view.backgroundColor = .black
        presenter.setDelegate(delegate: self)
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        presenter.fetchData()
    }
}
