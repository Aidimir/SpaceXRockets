//
//  launchView.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 21.03.2022.
//

import Foundation
import UIKit
import SnapKit

class LaunchView : UIView{
    var name : String
    var launchInfo : [String:String]
    let view = UIView()
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let successImg : UIImageView = {
        let img = UIImage(named: "success")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    let failureImg : UIImageView = {
        let img = UIImage(named: "failure")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()

    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = UIColor(red: 0.142, green: 0.142, blue: 0.142, alpha: 1)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    init(launchInfo : [String:String], name : String){
        self.launchInfo = launchInfo
        self.name = name
        super.init(frame: .zero)
        nameLabel.text = name
        dateLabel.text = launchInfo["date"]
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        var imgView = UIImageView()
        if launchInfo["success"] == "true"{
            imgView = successImg
        }
        else{
            imgView = failureImg
        }
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.9*0.75)
            make.top.left.equalTo(view)
            make.height.equalTo(view).dividedBy(2)
        }
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.height.width.equalTo(nameLabel)
        }
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(view)
            make.height.equalTo(view)
            make.width.equalTo(view).dividedBy(4)
        }
        view.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalToSuperview()
        }
    }
}
