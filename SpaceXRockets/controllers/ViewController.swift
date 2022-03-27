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
import SwiftUI
import BLTNBoard
class ViewController: UIViewController {
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private var boardManager : BLTNItemManager?
    private var pagesCount = 0
    private let pageControl : UIPageControl = {
        let pgControl = UIPageControl()
        return pgControl
    }()
    let presenter = Presenter()
    private let spinner = UIActivityIndicatorView()
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
        NotificationCenter.default.addObserver(self, selector: #selector(showCard), name: NSNotification.Name("showCard"), object: nil)
    }
    @objc func tryToConnectAgain(sender : UIRefreshControl){
        sender.endRefreshing()
        presenter.fetchData()
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if view.subviews.count > 1 {
        print(pageControl.currentPage)
        print(scrollView.frame.maxX)
        print(view.frame.maxX)
        scrollView.setContentOffset(CGPoint(x: Int(Int(scrollView.frame.maxX)/pagesCount * pageControl.currentPage), y: 0), animated: false)
        }
    }
}

extension ViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}

extension ViewController{
    @objc func showCard(notification : NSNotification){
        boardManager = {
           let item = BLTNPageItem(title: "Что то пошло не так...")
            item.image = UIImage(named: "errorImage")
            item.descriptionText = notification.object as? String ?? ""
            item.actionButtonTitle = "Попробовать подключиться снова"
            item.actionHandler = { [weak self] _ in
                self?.onCardTap()
            }
            return BLTNItemManager(rootItem: item)
        }()
        boardManager!.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.boardManager!.showBulletin(above: self)
        }
    }
    func onCardTap(){
        boardManager!.dismissBulletin()
        presenter.fetchData()
    }
}


extension ViewController : UserPresenterDelegate{
    func errorHandler() {
        spinner.removeFromSuperview()
        if view.subviews.count == 0 {
            let scroll = UIScrollView()
            let refreshControl : UIRefreshControl = {
                let refresh = UIRefreshControl()
                refresh.addTarget(self, action: #selector(tryToConnectAgain(sender: )), for: .valueChanged)
                refresh.tintColor = .white
                return refresh
            }()
            scroll.refreshControl = refreshControl
            let errorImgView = UIImageView(image: UIImage(named: "errorImage"))
            scroll.addSubview(errorImgView)
            errorImgView.snp.makeConstraints { make in
                make.left.right.centerY.width.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
            }
            view.addSubview(scroll)
            scroll.snp.makeConstraints { make in
                make.left.right.top.bottom.width.height.equalToSuperview()
            }
        }
        else{}
    }
    func presentRockets(rocketsDict: [String : RocketData]) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            return scrollView
        }()
        let massiveView = UIView()
        let stackView : UIStackView = {
            let stack = UIStackView()
            stack.distribution = .fillEqually
            stack.axis = .horizontal
            return stack
        }()
        var pages = [RocketPageController]()
        if UserDefaults.standard.dictionary(forKey: "values")?.isEmpty == false{
            defaultUnits = UserDefaults.standard.dictionary(forKey: "values") as! [String: String]
        }
        scrollView.delegate = self
        pageControl.numberOfPages = rocketsDict.count
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
            pagesCount += 1
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
            make.top.left.right.width.height.equalToSuperview()
            //            make.height.equalToSuperview().multipliedBy(0.95)
        }
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.centerX.width.equalToSuperview()
        }
    }
}
