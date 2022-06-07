//
//  bottom_scrollView.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 17.03.2022.
//

import Foundation
import UIKit
import SnapKit

class BottomScrollView : UIView{
    private let cells : [BottomScrollViewCell]
    private let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    private let view = UIView()
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    init(cells : [BottomScrollViewCell]){
        self.cells = cells
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(){
        for i in cells{
            stackView.addArrangedSubview(i)
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view)
        }
        scrollView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(1.3)
            make.height.equalTo(scrollView)
        }
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
