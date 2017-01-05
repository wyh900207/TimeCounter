//
//  ViewController.swift
//  EnumTest
//
//  Created by 王源鸿 on 17/1/4.
//  Copyright © 2017年 HomerIce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var timeCounterView: TimeCounterView = {
        let timeCounterView = TimeCounterView(time: "10:10:10")
        return timeCounterView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        let error: MyError = MyError.success
//        error.logError()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UI
extension ViewController {
    fileprivate func setupUI() {
        view.addSubview(timeCounterView)
        timeCounterView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
    }
}

// MARK: - Enum
extension ViewController {
    enum MyError: Int {
        case success = 0
        case error400
        case error404

        func logError() {
            switch self {
            case .success:
                print("success")
            case .error400:
                print("400")
            case .error404:
                print("404")
            }
        }
    }

}

