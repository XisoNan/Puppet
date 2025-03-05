//
//  BaseNavigationViewController.swift
//  Project
//
//  Created by 1234 on 2024/3/11.

import UIKit
class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()//改变全局
        appearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 0), for: .default)
        navigationBar.isTranslucent = true//设置导航栏半透明
        navigationBar.barTintColor = UIColor(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 0.8)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 38 / 255.0, green: 38 / 255.0, blue: 38 / 255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        navigationBar.tintColor = UIColor(red: 38 / 255.0, green: 38 / 255.0, blue: 38 / 255.0, alpha: 1.0)

        // 开启单独导航栏
        navigation.configuration.isEnabled = true

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true//TabBar嵌套Nav，Navpush时隐藏tabbar
        }
        super.pushViewController(viewController, animated: true)
    }
}



