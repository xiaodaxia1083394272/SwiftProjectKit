//
//  SPSwiftBlockVC.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPSwiftBlockVC: UIViewController {

    var testSwiftBlcokObjcet : SPTestSwiftBlcokObjcet?
    
    @IBOutlet weak var testLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSwiftBlcokObjcet = SPTestSwiftBlcokObjcet()
    }
    
    
    @IBAction func clickTestBtn(_ sender: Any) {
        /*
         self.一般是可以省略掉，但以下情况除外
         1> 如果该方法中有局部变量和成员属性有歧义（名称相同）
         2> 在闭包中使用成员属性
         对于闭包中的循环引用的问题：
         如果所在的类对闭包强引用了，就有必要使用weakself，并且是以可选链的方式
         
         pss_swift的强类型特性也是够了，
         定个weakSelf一定要指定是那个控制器，
         给个UIViewController还不行
         */
        weak var weakSelf : SPSwiftBlockVC? = self
        
        testSwiftBlcokObjcet?.loadData({ (jsonData : String) in
           
            weakSelf?.testLB.text = jsonData
        })
        
    }
 
}
