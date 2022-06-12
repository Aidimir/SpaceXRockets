//
//  settings_page_controller.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 20.03.2022.
//

import Foundation
import UIKit
import SnapKit

class SettingPageController : UIViewController{
    private let presenter = SettingsPresenter()
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private let stack : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    private let closeButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        let label = UILabel()
        label.text = "Закрыть"
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 25)
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.height.width.left.right.top.bottom.equalTo(button)
        }
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.spacing = view.frame.size.height*0.04
        view.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
        let allParams = [Settings.shared.heightParameter, Settings.shared.payloadWeightsParameter,Settings.shared.massParameter, Settings.shared.diameterParameter]
        for param in allParams.sorted{$0.parameterName<$1.parameterName} {
            let settingsButton = SettingsButton(parameter: param)
            stack.addArrangedSubview( settingsButton)
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.top.equalToSuperview().offset(view.frame.size.height*0.02)
        }
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
            make.height.equalToSuperview().dividedBy(3)
        }
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(label)
            make.right.equalTo(stack)
            make.width.equalToSuperview().dividedBy(4)
            make.height.equalTo(label)
        }
    }
    @objc private func onTap(){
        dismiss(animated: true, completion: nil)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orient = UIApplication.shared.statusBarOrientation
        switch orient {
        case .unknown:
            stack.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
                make.height.equalToSuperview()
            }
        case .portrait:
            stack.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
                make.height.equalToSuperview().multipliedBy(0.7)
            }
        case .portraitUpsideDown:
            stack.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
                make.height.equalToSuperview().multipliedBy(0.7)
            }
        case .landscapeLeft:
            stack.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
                make.height.equalToSuperview().multipliedBy(0.7)
            }
        case .landscapeRight:
            stack.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(view.frame.size.height*0.05)
                make.height.equalToSuperview().dividedBy(3)
            }
            super.viewWillTransition(to: size, with: coordinator)
        }
    }
    deinit {
        print("DEINITED CONTROLLER")
    }
}
