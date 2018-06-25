//
//  YFHomeLabelButton.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFHomeLabelButton: UIButton {

    let NormalSize = 11
    let SelectSize = 20
    
    /**
     *  传入一个百分值来调整按钮内部的细节
     *
     *  @param percent 按钮占据的百分比
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(kRedColor, for: .normal)
        self.titleLabel?.font = kFont(15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //pss_赞，以重写父类方法的信息，监听按钮的点击事件
    override func select(_ sender: Any?) {
        super.select(sender)
        if (isSelected) {
         self.setTitleColor(kYellowColor, for: .selected)
        } else {
            self.setTitleColor(kBlackColor, for: .selected)
        }
    }
    
    public func adjust(_ percent : CGFloat){
        
        // 调整文字大小
        let size : CGFloat = CGFloat(NormalSize) + CGFloat(SelectSize - NormalSize) * percent
        self.titleLabel?.font = kFont(size)
        
        // 调整颜色
        self.setTitleColor(kYellowColor, for: .selected)
        self.setTitleColor(kBlackColor, for: .normal)
    }
}
