//
//  launches_page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 21.03.2022.
//

import Foundation
import UIKit
import SnapKit
import CoreAudioTypes

class LaunchesPageController : UIViewController{
    var allRocketLaunches : [String : [String:String]]?
    private let stack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    private let massiveView = UIView()
    private let scrollView : UIScrollView = {
       let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    func createStack(){
        for (key,value) in allRocketLaunches!{
            stack.addArrangedSubview(LaunchView(launchInfo: value, name: key))
        }
        massiveView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalTo(massiveView)
        }
        scrollView.addSubview(massiveView)
        massiveView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalTo(scrollView)
            make.height.equalTo(scrollView).multipliedBy(0.2*Double(allRocketLaunches!.count))
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.centerX.bottom.height.equalToSuperview()
        }
    }
    let labelIfEmpty : UILabel = {
       let label = UILabel()
        label.text = "Информации о запусках нет"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.spacing = view.frame.size.height*0.03
        view.backgroundColor = .black
        if allRocketLaunches?.isEmpty == true {
            view.addSubview(labelIfEmpty)
            labelIfEmpty.snp.makeConstraints { make in
                make.left.right.top.bottom.centerX.width.height.equalToSuperview()
            }
        }
        else{
        createStack()
        }
    }
}
