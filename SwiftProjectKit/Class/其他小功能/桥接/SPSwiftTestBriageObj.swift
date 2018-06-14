//
//  SPSwiftTestBriageObj.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPSwiftTestBriageObj: NSObject {

    /*
     闭包类型:（_ 参数列表，多得话就用逗号隔开) -> (返回值类型）
     参数标识符前面加下划线的话，表明是内部函数
     @escaping : 逃逸的 ,如果闭包在其他闭包中使用，必须加上这个关键词。
     */
    
   public func loadData (_ finishedCallback : @escaping (_ jsonData :String) ->()) {
        // 1.发送异步网络请求
        DispatchQueue.global().async {
            print ("发送异步网络请求:\(Thread.current)")
            DispatchQueue.main.sync {
                print ("回到主线程:\(Thread.current)")
                finishedCallback("oc调起swift")
            }
        }
    }
}
