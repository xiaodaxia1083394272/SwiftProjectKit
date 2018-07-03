//
//  YFBlurtViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFBlurtViewController: UIViewController {
    /*
     pss_原理，
     UITableView 是 UIScrollView 的子类。
     所以 UIScrollView 的代理方法，在UITableView 上同样能够得到适用。
     既然如此那么我们就能够知道，在表格下拉的过程中，需要让头部的图片能够有稍微放大的效果出现，我们可以根据滚动视图滚动监听事件，通过获取表格下拉的拉伸量，从而去改变图片的大小即可！
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kWhiteColor
//        let b : YFBlurtView = [[YFBlurtView alloc] initWithFrame:self.view.frame WithHeaderImgHeight:170 iconHeight:100 selectBlock:^(NSIndexPath *indexPath) {
//            NSLog(@"indexpath.row is %zi indexpath.section is %zi",indexPath.row,indexPath.section);
//            }];
//        [self.view addSubview:b];

    }
}
