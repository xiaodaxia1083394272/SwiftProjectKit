//
//  XPageBarExtension.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/27.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import Foundation
//pss_13.扩展的时候经常要补上UIKit，最喜欢做的就是把方法给扩展了
import UIKit

extension XPageBar{
    func addTitleLabelToPageBar() -> Void {
        var X:CGFloat = 0
        //pss_14  0 ..之前要隔开一个空格！
        for i in 0 ..< self.titleArr.count{
            
            let title = self.titleArr[i]
            let titleLabel = UILabel(frame:CGRect(x: X, y: 0, width: 0, height: 44))
            titleLabel.textColor = self.itemColor
            titleLabel.text = title
            titleLabel.textAlignment = .center
            //pss_15.font的语法是有变的。注意了
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.labelFitToText()
            self.scrollView.addSubview(titleLabel)
            X += titleLabel.frame.size.width
            //pss_todo
//            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClicked(_:)))
            
            self.titleLabelArr.append(titleLabel)
            
            
        }
        self.scrollView.contentSize.width = X
    }
     func titleLabelClicked(tap:UITapGestureRecognizer) -> Void {
        
    }
}
//pss_todo  15  14:28
//Label自适应
extension UILabel{
    func labelFitToText(){
        let content:NSString = NSString(string:self.text!)
        let size = content.boundingRect(with: CGSize(width:0,height:44), options: .usesLineFragmentOrigin, attributes:[NSAttributedStringKey.font:self.font] , context: nil)
        self.frame.size.width = size.width + 60
    }
}
