//
//  YFNeteaseHomeViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFNeteaseHomeViewController: UIViewController,UIScrollViewDelegate {

   /*
     pss_原理，就是通过title的view取其index；
     通过index切换的时候，通过类似懒加载的方式，如果没有add到父ScollerView；
     根据内容子vc和调整父ScollerView的偏移量；
     
     反过来然后通过scollView的偏移去计算标题的index，并进行相应的移动
     */
    /** 存放标签 */
    var labelsScrollView : UIScrollView!
    /** 存放具体的子控制器 */
    var contentsScrollView : UIScrollView!
    var selectedButton : YFHomeLabelButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = kWhiteColor
        
        labelsScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenW, height: 44))
        labelsScrollView.backgroundColor = kWhiteColor
        self.view.addSubview(labelsScrollView)

        contentsScrollView = UIScrollView(frame: CGRect(x: 0, y: self.labelsScrollView.frame.maxY, width: kScreenW, height: kScreenH - self.labelsScrollView.frame.size.height))
        contentsScrollView.backgroundColor = kGreenColor
        self.view.addSubview(contentsScrollView)
        
        // 初始化子控制器
        setupChildVcs()
        
        // 初始化顶部标签
        setupLabels()

    }

}

extension YFNeteaseHomeViewController {
    /**
     *  初始化顶部标签
     */
    func setupLabels(){
        
        // 不要刻意去调整scrollView的contentInset
        self.automaticallyAdjustsScrollViewInsets = false
        var labelButtonW = CGFloat(90.0)
        let count = self.childViewControllers.count
        for i in 0..<count{
            // 取出i位置对应的子控制器
            let childVc = self.childViewControllers[i]
            // 添加标签
            let labelButton = YFHomeLabelButton()
            labelButton.frame.size.height = self.labelsScrollView.frame.size.height
            print("height = \(self.labelsScrollView.frame.size.height)")
            labelButton.frame.size.width = labelButtonW;
            labelButton.frame.origin.y = 0
            labelButton.frame.origin.x = CGFloat(i) * labelButtonW
            labelButton.setTitle(childVc.title, for: .normal)
            labelButton.addTarget(self, action: #selector(YFNeteaseHomeViewController.labelClick(labelButton:)), for: UIControlEvents.touchUpInside)
            self.labelsScrollView.addSubview(labelButton)
        }
      
        // 设置内容大小
        self.labelsScrollView.contentSize = CGSize(width: CGFloat(count) * labelButtonW, height: 0.0)
        self.contentsScrollView.contentSize = CGSize(width: CGFloat(count) * kScreenW, height: 0.0)
        
        // 设置输入法
        self.contentsScrollView.delegate = self;
    }
    
    /**
     *  初始化子控制器
     */
    func setupChildVcs(){
        
        let titleList = ["头条","政治","经济","体育","国际","哈哈","呵呵"]
        
        for i in 0..<titleList.count{
            let vc = YFHealineViewController()
            vc.title = titleList[i]
            self.addChildViewController(vc)
        }
    }
}

extension YFNeteaseHomeViewController{
    //MARK:私有方法
    /**
     *  监听按钮点击
     */
    @objc func labelClick(labelButton : YFHomeLabelButton){
        
        // 切换按钮状态
        self.selectedButton.isSelected = false
        labelButton.isSelected = true
        self.selectedButton = labelButton
        
        // 切换子控制器
        //pss_赞，直接通过scollView上的view取index，还可以这样玩，不错喔
        let index = self.labelsScrollView.subviews.index(of: labelButton)
        if index != nil {
            switchChildVc(index!)
        }
    }
    
    /**
     *  切换子控制器
     *
     *  @param index 子控制器对应的索引
     */
    func switchChildVc(_ index : NSInteger){
       
        // 添加index位置对应的控制器
        let newChildVc : UIViewController? = self.childViewControllers[index]
        if newChildVc?.view.subviews == nil{
            newChildVc?.view.frame.origin.y = 0
            newChildVc?.view.frame.size.width = self.contentsScrollView.frame.size.width
            newChildVc?.view.frame.size.height = self.contentsScrollView.frame.size.height;
            newChildVc?.view.frame.origin.x = CGFloat(index) * (newChildVc?.view.frame.size.width)!
            self.contentsScrollView.addSubview((newChildVc?.view)!)
        }

        // 滚动到index控制器对应的位置
        self.contentsScrollView .setContentOffset(CGPoint(x: (newChildVc?.view.frame.origin.x)!, y: 0), animated: true)
        
        // 让被点击的标签按钮显示在最中间
        var offsetX = self.selectedButton.frame.midX - self.labelsScrollView.frame.size.width * 0.5
        let maxOffsetX = self.labelsScrollView.contentSize.width - self.labelsScrollView.frame.size.width
        if offsetX < 0 {
            offsetX = 0
        } else if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        let offset = CGPoint(x:offsetX, y:0)
        self.labelsScrollView.setContentOffset(offset, animated: true)
    }
    //MARK:UIScrollViewDelegate
    /**
     *  当scrollView减速完毕时调用
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        let labelButton : YFHomeLabelButton = self.labelsScrollView.subviews[Int(index)] as! YFHomeLabelButton
        self.labelClick(labelButton: labelButton)
    }
    /**
     *  当scrollView正在滚动时调用
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let value = scrollView.contentOffset.x / scrollView.frame.width
        let oneIndex = NSInteger(value)
        let twoIndex = NSInteger(oneIndex + 1)
        let twoPercent = value - CGFloat(oneIndex)
        let onePercent = 1 - twoPercent
        
        let oneButton : YFHomeLabelButton  = self.labelsScrollView.subviews[oneIndex] as! YFHomeLabelButton
        oneButton.adjust(onePercent)
        
        if (twoIndex < self.labelsScrollView.subviews.count) {
            
            let twoButton : YFHomeLabelButton  = self.labelsScrollView.subviews[twoIndex] as! YFHomeLabelButton
            twoButton.adjust(twoPercent)
        }
    }
    
}

