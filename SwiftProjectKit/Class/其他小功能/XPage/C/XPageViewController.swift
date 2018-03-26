//
//  XPageViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/26.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class XPageViewController: UIViewController {
    let width = UIScreen.main.bounds.size.width
    let heigt = UIScreen.main.bounds.size.height

    var XScrollView:UIScrollView!//pss_6.现在的类属性都喜欢这样声明的吗？或者说，swift中没有属性的概念？
    let PageBar = XPageBar()
    var controllers:Array<UIViewController>! = []{
        //pss_8.就喜欢监听属性,构造一些初始的方法之类的。
        didSet{
            print("")
            self.addViewToSelf()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.XScrollView = UIScrollView(frame:self.view.frame)
        self.XScrollView.showsVerticalScrollIndicator = false
        self.XScrollView.showsHorizontalScrollIndicator = false
        self.XScrollView.isPagingEnabled = true//分页显示
        self.XScrollView.bounces = false//不弹性
        view.addSubview(self.XScrollView)
    }
    //pss_7.构造函数为什么一定要这一坨，目前还不太清楚
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分页控制器"

    }


}
