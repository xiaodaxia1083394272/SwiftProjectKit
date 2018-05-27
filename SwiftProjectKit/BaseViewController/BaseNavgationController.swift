//
//  BaseNavgationController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController,UINavigationControllerDelegate {
    //初始化导航栏之公共导航栏设置
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let textAttributes = [NSAttributedStringKey.font:kFont(18),NSAttributedStringKey.foregroundColor:kWhiteColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
            UINavigationBar.appearance().tintColor = kWhiteColor
        UINavigationBar.appearance().barTintColor = kRedColor
        //导航栏半透明
        UINavigationBar.appearance().isTranslucent = true
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true
        }
        //跳到子VC前，隐藏tabbar
        super.pushViewController(viewController, animated: animated)
    }
    

}
