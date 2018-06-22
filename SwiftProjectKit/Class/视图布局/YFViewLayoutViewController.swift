//
//  YFViewLayoutViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/21.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFViewLayoutViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        [self setupDataArr:@[@[@"水平滚动布局",@"SPHorizontalScrollViewController"],
//            @[@"瀑布流布局",@"YFWaterflowViewController"],
//            @[@"浏览卡",@"RGCardLayoutViewController_UIStoryboard"],
//            @[@"半圆布局",@"YFHalfCircleLayoutViewController_UIStoryboard"],//pss_屏
//            @[@"滑动标题",@"YFSlideTitlesViewController"],
//            @[@"网易滑动标题",@"YFNeteaseHomeViewController"],
//            @[@"抽卡效果",@"YFStackedPageVC_UIStoryboard"],]];
         self.setupDataArr(dataArr: [["水平滚动布局","SPHorizontalScrollViewController"],["瀑布流布局","YFWaterflowViewController"],]);
    }


}
