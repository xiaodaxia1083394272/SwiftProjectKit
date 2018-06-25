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
        self.setTitleColor(kBlackColor, for: .normal)
        self.setTitleColor(kRedColor, for: .selected)
        self.titleLabel?.font = kFont(15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //pss_即使是父类的一样可以监听
    override var isSelected: Bool{
        //pss_如果要利于变化之后的属性值一定要用didSet,不要用willSet,willSet是值还没有变的
        didSet{
            if (isSelected) {
                self.setTitleColor(kRedColor, for: .selected)
                print("选中")
            } else {
                self.setTitleColor(kBlackColor, for: .selected)
                print("没选中")
            }
        }
    }
    
    public func adjust(_ percent : CGFloat){
        
        // 调整文字大小
        let size : CGFloat = CGFloat(NormalSize) + CGFloat(SelectSize - NormalSize) * percent
        self.titleLabel?.font = kFont(size)
        
        // 调整颜色
        self.setTitleColor(kRedColor, for: .selected)
        self.setTitleColor(kBlackColor, for: .normal)
    }
}
