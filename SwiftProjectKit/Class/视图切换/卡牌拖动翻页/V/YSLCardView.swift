//
//  YSLCardView.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YSLCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCardView(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.4;
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.cornerRadius = 7.0;
    }
}
