//
//  BaseNavgationController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
            UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.red
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
