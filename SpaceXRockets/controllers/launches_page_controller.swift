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
    var name : String?
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
            make.centerX.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
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
        createCloseButtonAndLabel()
    }
    func createCloseButtonAndLabel(){
        let button = UIButton()
        let label : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 25)
            label.textAlignment = .left
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white
            label.text = " Назад"
            return label
        }()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalTo(button)
        }
        let imgView : UIImageView = {
            let imgView = UIImageView(image: UIImage(systemName: "chevron.left"))
            imgView.tintColor = .white
            imgView.contentMode = .scaleAspectFit
            return imgView
        }()
        button.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.bottom.equalTo(button)
            make.right.equalTo(button.snp.left)
        }
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height*0.03)
            make.left.equalToSuperview().offset(view.frame.width*0.05)
            make.width.equalToSuperview().dividedBy(4)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        let nameLabel : UILabel = {
           let label = UILabel()
            label.text = name
            label.font = .systemFont(ofSize: 25)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.textColor = .white
            return label
        }()
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(button.snp.right)
            make.top.equalTo(button)
            make.height.equalTo(button)
        }
    }
    @objc func onTap(){
        self.dismiss(animated: true, completion: nil)
    }
}
