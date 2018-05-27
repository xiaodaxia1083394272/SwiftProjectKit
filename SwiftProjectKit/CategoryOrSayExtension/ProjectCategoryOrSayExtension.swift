//
//  ProjectCategoryOrSayExtension.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/5/27.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import Foundation
import UIKit

//MARK:颜色扩展（分类）
extension UIColor {
    //颜色16进制
    
    //MARK:16进制颜色  "#00FF07"
    public func hexCOLOR(_ hexString: String) -> UIColor{

        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //swift4.0字符串的长度直接用count就行了
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
//            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
            //直接转成NSString来截取从开始到2位会简单点
              cString =  (cString as NSString).substring(to:2)
        }
        if cString.hasPrefix("#") {
//            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
            cString =  (cString as NSString).substring(to:1)

        }
        if cString.count != 6 {
            return UIColor.black
        }

        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)

        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        //下面这个方法ios10以上才有
//        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))

    }

}

