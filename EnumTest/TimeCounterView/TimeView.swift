//
//  TimeView.swift
//  EnumTest
//
//  Created by 王源鸿 on 17/1/5.
//  Copyright © 2017年 HomerIce. All rights reserved.
//

import UIKit
import SnapKit

class TimeView: UIView {

    // MARK: - Propeties
    var time: Int = 0 {
        didSet {
            updateTime()
        }
    }

    // MARK: - Lazy load
    fileprivate lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = UIColor.orange
        timeLabel.font = UIFont.systemFont(ofSize: 50)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        timeLabel.layer.cornerRadius = 10
        timeLabel.layer.masksToBounds = true
        return timeLabel
    }()

    // MARK: Initializtion
    init(time: Int) {
        self.time = time
        super.init(frame: CGRect.zero)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI
extension TimeView {
    fileprivate func setupUI() {
        addSubview(timeLabel)
        updateTime()
        timeLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
}

// Private methods
extension TimeView {
    fileprivate func updateTime() {
        timeLabel.text = String(format: "%02i", time)
    }
}
