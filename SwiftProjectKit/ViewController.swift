//
//  ViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/15.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = arc4random()%255
        let g = arc4random()%255
        let b = arc4random()%255
        self.view.backgroundColor = UIColor(displayP3Red: r.FloatValue/255, green: g.FloatValue/255, blue: b.FloatValue/255, alpha: 1)

    }



}

