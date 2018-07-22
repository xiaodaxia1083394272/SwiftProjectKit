//
//  XYAlertView.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/7/23.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class XYAlertView: UIView {
    //单例
    public static let ShareAlert = XYAlertView()
    let  kContentWidth = kFitW(311)
    let  kContentHeight = kFitW(200)
    
    fileprivate let bgBtn: UIButton = UIButton(type: .custom)
    fileprivate let contentView: UIView = UIView()
//    fileprivate let titleLB: UILabel = UILabel(frame: CGRect(x: kFitW(17), y: kFitW(5), width: kContentWidth - kFitW(24), height: kFitH(14)))
    fileprivate let msgLB: UILabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension XYAlertView{
    func setupView(){
        self.addSubview(self.bgBtn)
//        self.bgBtn.addSubview(self.contentView)
//        self.contentView.addSubview(self.titleLB)
//        self.contentView.addSubview(self.msgLB)
    }
    func setupLayout(){
        //
        bgBtn.frame = CGRect(x:0, y:0,width:kScreenW, height:kScreenH)
        bgBtn.backgroundColor = UIColor.gray
        bgBtn.alpha = 0.5
        bgBtn.addTarget(self, action: #selector(bgBtnClicked(_:)), for: .touchUpInside)
        //
//        titleLB.font = kFont(15)
//        titleLB.textColor = UIColor.hexCOLOR("#707070")
//        textColor.lineBreakMode = NSLineBreakByCharWrapping | NSLineBreakByTruncatingTail;
        //
//        contentView = [[UIView alloc] initWithFrame:CGRectMake((kFXScreenWidth - kContentWidth)/2, (kFXScreenHeight - kContentHeight)/2, kContentWidth, kContentHeight)];
//        v.backgroundColor = [UIColor whiteColor];
//        v.layer.cornerRadius = 5;
//        v.layer.masksToBounds = YES;
//        _contentView = v;
    }
    
    @objc func bgBtnClicked(_ sender: UIButton) {
        
    }
    
    public func show(){
//    __weak typeof(self) wself = self;
//    [UIView animateWithDuration:0.3 animations:^{
//    UIView *window = [UIApplication sharedApplication].keyWindow;
//    [wself removeFromSuperview];
//    [window addSubview:wself];
//    [window bringSubviewToFront:wself];
//    }];
        weak var weakSelf : XYAlertView? = self
        UIView.animate(withDuration: 0.3) {
           let window = UIApplication.shared.keyWindow
            weakSelf?.removeFromSuperview()
            if weakSelf != nil{
                window?.addSubview(weakSelf!)
                window?.bringSubview(toFront: weakSelf!)
            }
        }
    }
}



