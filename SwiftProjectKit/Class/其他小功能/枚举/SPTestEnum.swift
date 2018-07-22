//
//  SPTestEnum.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/7/23.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPTestEnum: NSObject {

    //MARK:1.枚举加计算属性
    /*
     属性(Properties)
     尽管增加一个存储属性到枚举中不被允许，但你依然能够创建计算属性。
     当然，计算属性的内容都是建立在枚举值下或者枚举关联值得到的。
     */
    enum Device {
        case iPad, iPhone
        var year: Int {
            switch self {
            case .iPhone: return 2007
            case .iPad: return 2010
            }
        }
    }
    
    public class func testEnum(device:Device){
        print(device.year)
    }
}
