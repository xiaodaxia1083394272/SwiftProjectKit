//
//  FriendViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class FriendViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = ["7","5","6"]
        var b = ["1","2","3"]
        let c = b
        b = a + c
        print("\(c)")
    }


}
