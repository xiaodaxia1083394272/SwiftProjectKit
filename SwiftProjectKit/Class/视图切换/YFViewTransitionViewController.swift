//
//  YFViewTransitionViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFViewTransitionViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.setupDataArr(dataArr: [["卡牌拖动翻页","YFDraggableCardViewController"],]);
    }
}
