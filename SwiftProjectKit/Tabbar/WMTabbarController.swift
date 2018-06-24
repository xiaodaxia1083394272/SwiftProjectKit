//
//  WMTabbarController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class WMTabbarController: UITabBarController {
    var aliPay = AlipayViewController()
    var reputationVC = ReputationViewController()
    var friendVC = FriendViewController()
    var moneyVC = MoneyViewController()
    
    func creatSubViewControllers(){
        //pss_初始化tabbar
        let aliNav = BaseNavgationController(rootViewController:aliPay)
        let aliItem = UITabBarItem.init(title: "首页", image: UIImage.init(named: "TabBar_Assets"), selectedImage: UIImage.init(named: "TabBar_Assets_Sel"))
        aliNav.tabBarItem = aliItem
        
        let reputationNav = BaseNavgationController(rootViewController:reputationVC)
        let reputationItem = UITabBarItem.init(title: "测试1", image: UIImage.init(named: "TabBar_Businesses"), selectedImage: UIImage.init(named: "TabBar_Businesses_Sel"))
        reputationNav.tabBarItem = reputationItem;
        
        let friendNav = BaseNavgationController(rootViewController: friendVC)
        let friendItem = UITabBarItem.init(title: "测试2", image: UIImage.init(named: "TabBar_Friends"), selectedImage: UIImage.init(named: "TabBar_Friends_Sel"))
        friendNav.tabBarItem = friendItem;
        
        let moneyNav = BaseNavgationController(rootViewController: moneyVC)
        let moneyItem = UITabBarItem.init(title: "测试3", image: UIImage.init(named: "TabBar_Assets"), selectedImage: UIImage.init(named: "TabBar_Assets_Sel"))
        moneyNav.tabBarItem = moneyItem;
        
        self.viewControllers = [aliNav,reputationNav,friendNav,moneyNav];
        //        self.tabBar.tintColor = UIColor.redColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建tabbar的子控制器
        self.creatSubViewControllers()
    }
}
