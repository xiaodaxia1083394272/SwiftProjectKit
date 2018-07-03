//
//  YFBlurtView.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/7/3.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFBlurtView: UIView {

    var headerImgHeight = 0;
    var iconHeight = 0;
    /**
     *  图片url
     */
    var imgUrl = ""
    var name = ""
    // 1.定义一个闭包类型
    //格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
    typealias SelectRowAction = (_ indexPath: NSIndexPath) -> Void
    //2. 声明一个变量
    var selectAction: SelectRowAction?
    
//        - (instancetype)initWithFrame:(CGRect)frame WithHeaderImgHeight:(CGFloat)headerImgHeight iconHeight:(CGFloat)iconHeight selectBlock:(SelectRowAction)block {
//    if (self = [super initWithFrame:frame]) {
//    self.headerImgHeight = (headerImgHeight == 0  ? self.frame.size.height * 0.382 : headerImgHeight);
//    self.iconHeight = (iconHeight == 0  ? self.frame.size.height * 0.382  : iconHeight);
//    [self setupContentView];
//    selectAction = block;
//
//    }
//    return self;
//    }
    
//     init(frame: CGRect,WithHeaderImgHeight:CGFloat,iconHeight:CGFloat,selectBlock:SelectRowAction) {
//        super.init()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
