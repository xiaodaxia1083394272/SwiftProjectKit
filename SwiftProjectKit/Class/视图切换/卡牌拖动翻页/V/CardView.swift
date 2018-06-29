//
//  CardView.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class CardView: YSLCardView {
    
    var  imageView : UIImageView!
    var  label : UILabel!
    var  selectedView : UIView!

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        
    imageView = UIImageView()
    imageView.backgroundColor = UIColor.orange
    
    imageView.frame = CGRect(x:0, y:0, width:self.frame.size.width,height:self.frame.size.height * 0.8)
    self.addSubview(imageView)
    
    var maskPath:UIBezierPath!
    //pss_贝塞尔曲线加CAShapeLayer画图
    //pss_赞，swift多枚举传入的正确写法
    maskPath = UIBezierPath.init(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 7.0, height: 7.0))
        
    let maskLayer = CAShapeLayer()
    maskLayer.frame = imageView.bounds;
        maskLayer.path = maskPath.cgPath;
        imageView.layer.mask = maskLayer;
    
    selectedView = UIView()
    selectedView.frame = imageView.frame
    selectedView.backgroundColor = UIColor.clear
    selectedView.alpha = 0.0;
    imageView.addSubview(selectedView)
    
    label = UILabel()
    label.backgroundColor = UIColor.clear
        label.frame = CGRect(x:10, y:self.frame.size.height * 0.8, width:self.frame.size.width - 20,height:self.frame.size.height * 0.2)
        label.font = UIFont(name: "Futura-Medium", size: 14)
    self.addSubview(label)
    }

}
