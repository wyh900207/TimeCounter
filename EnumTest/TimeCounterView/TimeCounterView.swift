//
//  TimeCounterView.swift
//  EnumTest
//
//  Created by 王源鸿 on 17/1/5.
//  Copyright © 2017年 HomerIce. All rights reserved.
//

import UIKit

class TimeCounterView: UIView {

    // MARK: - Lazy load
    fileprivate lazy var hourTimeView: TimeView = { // 小时
        let hourTimeView = TimeView(time: 0)
        return hourTimeView
    }()

    fileprivate lazy var minuteTimeView: TimeView = { // 分钟
        let minuteTimeView = TimeView(time: 0)
        return minuteTimeView
    }()

    fileprivate lazy var secondTimeView: TimeView = { // 秒
        let secondTimeView = TimeView(time: 0)
        return secondTimeView
    }()

    fileprivate lazy var leftColon: UILabel = { // 左边冒号
        let leftColon = UILabel()
        leftColon.text = ":"
        leftColon.font = UIFont.boldSystemFont(ofSize: 30)
        leftColon.textAlignment = .center
        return leftColon
    }()

    fileprivate lazy var rightColon: UILabel = { // 右边冒号
        let rightColon = UILabel()
        rightColon.text = ":"
        rightColon.font = UIFont.boldSystemFont(ofSize: 30)
        rightColon.textAlignment = .center
        return rightColon
    }()

    fileprivate var timer: Timer?

    fileprivate var hourTime: Int = 0
    fileprivate var minuteTime: Int = 0
    fileprivate var secondTime: Int = 0

    // MARK: - Propeties
    var time: String = "00:00:00" {
        didSet {
            updateTime()
        }
    }

    init(time: String) {
        self.time = time
        super.init(frame: CGRect.zero)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFire), userInfo: nil, repeats: true)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI
extension TimeCounterView {
    fileprivate func setupUI() {
        addSubview(hourTimeView)
        addSubview(leftColon)
        addSubview(minuteTimeView)
        addSubview(rightColon)
        addSubview(secondTimeView)

        updateTime()

        hourTimeView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
        }

        leftColon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(hourTimeView.snp.right)
            make.width.equalTo(30)
        }

        minuteTimeView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(leftColon.snp.right)
            make.width.equalTo(hourTimeView)
        }

        rightColon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(minuteTimeView.snp.right)
            make.width.equalTo(30)
        }

        secondTimeView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.left.equalTo(rightColon.snp.right)
            make.width.equalTo(hourTimeView)
        }
    }
}

// MARK: - Private methods
extension TimeCounterView {
    fileprivate func updateTime() {
        let times = separatedTime()

        hourTime = times.hourTime
        minuteTime = times.minuteTime
        secondTime = times.secondTime

        hourTimeView.time = hourTime
        minuteTimeView.time = minuteTime
        secondTimeView.time = secondTime
    }

    @objc fileprivate func timerFire() {

        if secondTime > 0 {
            secondTime -= 1
            secondTimeView.time = secondTime
        } else {
            if minuteTime > 0 {
                minuteTime -= 1
                secondTime += 59
                secondTimeView.time = secondTime
                minuteTimeView.time = minuteTime
            } else {
                if hourTime > 0 {
                    hourTime -= 1
                    minuteTime += 59
                    secondTime += 59
                    secondTimeView.time = secondTime
                    minuteTimeView.time = minuteTime
                    hourTimeView.time = hourTime
                } else {
                    timer?.invalidate()
                    time = "00:00:00"
                    updateTime()
                    print("倒计时结束")
                }
            }
        }
    }

    fileprivate func separatedTime() -> (hourTime: Int, minuteTime: Int, secondTime: Int) {
        let timeArray = time.components(separatedBy: ":")
        guard let hour = Int(timeArray[0]),
            let minute = Int(timeArray[1]),
            let second = Int(timeArray[2]) else { return (0, 0 ,0) }

        return (hour, minute, second)
    }
}
