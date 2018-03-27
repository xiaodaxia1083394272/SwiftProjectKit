//
//  XPageExtension.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/26.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
import Foundation

//pss_9,扩展VC也是幅度有点大啊
extension XPageViewController{
  
    func addViewToSelf(){
        var titeArray:Array<String> = []
        for i in 0..<controllers.count{
            let vc = controllers[i]
            //pss_10.i是int类型吗
            vc.view.frame.origin.x = i.CGFloatValue * self.width
            self.XScrollView.addSubview(vc.view)
            //pss_12.vc.title就是要强解一下，不是很看得明白
            titeArray.append(vc.title!)
        }
        //pss_11.swift的类型是挺让人蛋疼的事
        /*
         Binary operator '*' cannot be applied to operands of type 'Int' and 'CGFloat'
         二进制运算符*'不能应用于'Int'和'CGFloat'的操作数
         */
        self.XScrollView.contentSize = CGSize(width: self.controllers.count.CGFloatValue * self.width, height: self.heigt)
        self.PageBar.titleArr = titeArray
    }
}
