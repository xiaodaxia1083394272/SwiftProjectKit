//
//  YFDraggableCardViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFDraggableCardViewController: UIViewController {
    var datas = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        var container : YSLDraggableCardContainer!
        
        self.view.backgroundColor = RGB(235, 235, 235)
        
        // 创建 _container
        container = YSLDraggableCardContainer()
        container.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        container.backgroundColor = kClearColor
//        container.dataSource = self
//        container.delegate = self
//        _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
        self.view.addSubview(container)
        
        // 创建上下左右四个按钮
        for  i in 0..<4{
            
            let view = UIView()
            let size = self.view.frame.size.width / 4
            view.frame = CGRect(x:size * CGFloat(i), y:self.view.frame.size.height - 150, width:size, height:size)
            view.backgroundColor = UIColor.darkGray
            self.view.addSubview(view)
            
            let button = UIButton()
            button.frame = CGRect(x:10,y:10,width:(size - 20), height:(size - 20))
            button.backgroundColor = RGB(66, 172, 225)
            button.setTitleColor(kWhiteColor, for:.normal)
            button.titleLabel?.font = UIFont(name: "Futura-Medium", size: 18)
            button.clipsToBounds = true
            button.layer.cornerRadius = button.frame.size.width / 2;
            button.tag = i;
//            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            button.addTarget(self, action: #selector(YFDraggableCardViewController.buttonTap(button:)), for: UIControlEvents.touchUpInside)
            view.addSubview(button)
            
            if i == 0 {button.setTitle("Up", for: .normal)}
            if (i == 1) {button.setTitle("Down", for: .normal)}
            if (i == 2) {button.setTitle("Left", for: .normal)}
            if (i == 3) {button.setTitle("Right", for: .normal)}
        }
        // 获取数据
        loadData()
        // 给_container赋值
//        [_container reloadCardContainer];
    }
}

extension YFDraggableCardViewController{
    func loadData()
    {
        for i in 0..<7{
            let dict = ["image" :"photo_sample_0\(i + 1)",
                "name" : "YSLDraggableCardContainer Demo"]
            self.datas.append(dict)
        }
    }
    
    @objc func buttonTap(button : UIButton){
        if button.tag == 0 {
//            [_container movePositionWithDirection:YSLDraggableDirectionUp isAutomatic:YES];
        }
        if button.tag == 1 {
//            __weak YFDraggableCardViewController *weakself = self;
//            [_container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES undoHandler:^{
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
//                message:@"Do you want to reset?"
//                preferredStyle:UIAlertControllerStyleAlert];
//
//                [alertController addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                [weakself.container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES];
//                }]];
//
//                [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                [weakself.container movePositionWithDirection:YSLDraggableDirectionDefault isAutomatic:YES];
//                }]];
//
//                [self presentViewController:alertController animated:YES completion:nil];
//                }];
            
        }
        if button.tag == 2 {
//            [_container movePositionWithDirection:YSLDraggableDirectionLeft isAutomatic:YES];
        }
        if button.tag == 3 {
//            [_container movePositionWithDirection:YSLDraggableDirectionRight isAutomatic:YES];
        }
    }
}
