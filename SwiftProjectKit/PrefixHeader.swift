//
//  PrefixHeader.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/5/27.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

/*
 Swift的宏定义在本质上并不应该称之为宏定义, 只是为了方便大家的理解, 实质上是一些全局常量和函数,
*/


//MARK:屏幕宽、高
let kFullScreen = UIScreen.main.bounds
let kScreenH = UIScreen.main.bounds.size.height
let kScreenW = UIScreen.main.bounds.size.width

/*
 但是这种宏定义远远不能满足我们的需要, 如果想要实现上面的那种, 通过对view.X, 获取到view.frame.origin.x的方式, 就要想其他的办法了, 因为直接let x = frame.origin.x这种方式明显不合法
 
 这个时候还是想要那种便捷的方式, 就要通过函数来实现了, 把对象作为一个参数, 返回这个控件的具体属性(其实就是对frame的get方法的二次封装, 方便我们的使用), 下面会举例说明, 同样的, 对于其他的宏定义函数, 在这里同样适用
 */
//MARK:view尺寸的简便封装
//pss_前面写占位符_，对外可不写参数名
func x (_ object:UIView) ->CGFloat{
    
    return object.frame.origin.x;
}

func y (_ object:UIView) ->CGFloat{
    
    return object.frame.origin.y;
}

func width (_ object:UIView) ->CGFloat{
    
    return object.frame.size.width;
}

func height (_ object:UIView) ->CGFloat{
    
    return object.frame.size.height;
}


//MARK:状态栏高度
let kStatusBarH =  UIApplication.shared.statusBarFrame.size.height

//MARK:导航栏高度
let kNavBarH = CGFloat(44.0)
//MARK:导航栏+状态栏
let  kTopH = ((kScreenH==812.0 || kScreenW == 812.0) ? CGFloat(88.0) : CGFloat(64.0))

//MARK: Tabbar 安全区域边框.
let  kTabBarSafetyArea = ((kScreenH==812.0 || kScreenW == 812.0) ? CGFloat(34.0) : CGFloat(0.0))
//MARK:Tabbar高度
let kTabBarH = ((kScreenH==812.0 || kScreenW == 812.0) ? CGFloat(83.0) : CGFloat(49.0))
//MARK:iphone X 状态栏 与 非X 状态栏的 差值
let kStatusSpace = ((kScreenH==812.0 || kScreenW == 812.0) ? CGFloat(24.0) : CGFloat(0.0))

//MARK:不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6 如果不是则根据实际情况修改）//414 736
let kScreenWRatio = CGFloat(kScreenW  / 375.0)
let kScreenHRatio  = ((kScreenH==812.0) ? CGFloat((kScreenH-58.0) / 667.0) : CGFloat(kScreenH / 667.0))

let kIpadScreenWRatio = CGFloat(414.0  / 375.0)
let kIpadScreenHRatio = CGFloat(736.0 / 667.0)

//MARK:自动适配宽度、高度
let isIpad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) ? true : false

func kFitW(_ x : CGFloat) -> CGFloat{
    var x_vlaue = CGFloat(0.0)
    if isIpad {
        x_vlaue = x * kIpadScreenWRatio
    }else {
     x_vlaue =  x * kScreenWRatio
    }
    return x_vlaue;
}


func kFitH(_ h : CGFloat) -> CGFloat{
    var h_vlaue = CGFloat(0.0)
    if isIpad {
        h_vlaue = h * kIpadScreenHRatio
    }else {
        h_vlaue =  h * kScreenHRatio
    }
    return h_vlaue;
}

//MARK@2x 屏幕 (UI图pix为单位)
func FitPixW(_ x :CGFloat) -> CGFloat{
    
    return kFitW(x * 0.5)
}

func FitPixH(_ x :CGFloat) -> CGFloat{
    
    return kFitH(x * 0.5)
}

//MARK:字体大小(常规/粗体)
//粗体
func kBoldSysFont(_ size :CGFloat) -> UIFont{
    
    return UIFont.boldSystemFont(ofSize: kFitW(size))
}
//常规字体
func kFont(_ size :CGFloat) -> UIFont{

    return UIFont.systemFont(ofSize: kFitW(size))
}

func SysFontPix(_ size :CGFloat) -> UIFont{
    
    return kFont(size * 0.5)
}

//MARK:16进制颜色  "#00FF07"
//func hexCOLOR(_ size :String) -> UIColor{
//   
//    return UIColor.colorWithHexString(size)
//}





