//
//  SPTestDelegateObject.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

//不过后面带个class，指定只有类才能被委托比较好，否则连个枚举什么的也能被委托，怪怪的;(当然不指定也可以）
@objc protocol BuyTicketDelegate : class {
//    func buyTicket()

//    这些协议的方法默认都是必须实现的，如果想可选的话
    @objc optional func buyTicket(testCallBack:String)
}

class SPTestDelegateObject: NSObject {

    //定义代理属性
    weak var delegate : BuyTicketDelegate?
//    swift中很少见属性还带有修饰关键字了，然而代理属性比较例外，weak（weak貌似类中才能使用，这貌似也是协议定义后面跟个：class有关）用于防止产生循环引用，而oc中一般是用assin来修饰的。
    //2.协议方法的响应与执行，
    func goToBeijing(){
//        if let delegateOK = self.delegate{
//          delegateOK.buyTicket?(testCallBack: "testDelegateCallBack")
//        }
        //如果delegate的方法是必须实现的用这个调起
//        delegate?.buyTicket(testCallBack: "testDelegateCallBack")
        
        //如果delegate的方法是可选的用这个调起，没错区别就在后面的方法是否加“？”号
        delegate?.buyTicket?(testCallBack: "testDelegateCallBack")

    }
    

    
}
