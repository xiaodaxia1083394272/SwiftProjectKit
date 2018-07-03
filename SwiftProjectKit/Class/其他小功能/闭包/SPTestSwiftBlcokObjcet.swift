//
//  SPTestSwiftBlcokObjcet.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPTestSwiftBlcokObjcet: NSObject {
    //MARK:2.这种是拆开来的写法，比较灵活，比较常用
    
    // 1.定义一个闭包类型
    //格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
    typealias swiftBlock = (_ str: String) -> Void
    //2. 声明一个变量
    var callBack: swiftBlock?
    //3. 定义一个方法,方法的参数为和swiftBlock类型一致的闭包,并赋值给callBack
    func callBackBlock(block: @escaping (_ str: String) -> Void) {
        
        callBack = block
        buttonClick()
    }
 
    func buttonClick() {
        if self.callBack != nil
        {
            callBack!("这里的闭包传递了一个字符串")
        }
    }

}
extension SPTestSwiftBlcokObjcet{
    
}
extension SPTestSwiftBlcokObjcet{
    
   
}

//MARK:2.这种貌似是尾随闭包的写法
extension SPTestSwiftBlcokObjcet{
    
    /*
     闭包类型：（_ 参数列表，多得话就用逗号隔开) -> (返回值类型）
     @escaping : 逃逸的 ,如果闭包在其他闭包中使用，必须加上这个关键词。
     (参数标识符前面加下划线的话，表明是内部参数)
     */
    func loadData (_ finishedCallback : @escaping (_ jsonData :String) ->()) {
        // 1.发送异步网络请求
        DispatchQueue.global().async {
            print ("发送异步网络请求:\(Thread.current)")
            DispatchQueue.main.sync {
                print ("回到主线程:\(Thread.current)")
                finishedCallback("json数据")
            }
        }
    }
    
    /*
     oc 的写法
     - (void)loadDataWithFinishedCallback:(void(^)(NSString *jsonData)finishedCallback{
     
     if (finishedCallback) finishedCallback(@"json数据");
     
     });
     */
    
   
}

