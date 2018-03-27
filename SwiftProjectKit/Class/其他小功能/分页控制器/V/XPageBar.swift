//
//  XPageBar.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/26.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class XPageBar: UIView {
    
    let itemColor = UIColor.gray
    let itemSelectColor = UIColor.orange
    
    var scrollView:UIScrollView!
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    var titleLabelArr:Array<UILabel> = []
    var titleArr :Array<String> = []{
        didSet{
          self.addTitleLabelToPageBar()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.addSubview(self.scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
