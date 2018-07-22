//
//  SPEnumVC.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/7/22.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPEnumVC: UIViewController {
//pss_参考：https://blog.csdn.net/itchosen/article/details/77749152
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test1()
    }

}
extension SPEnumVC{
    func test1(){
       SPTestEnum.testEnum(device: .iPhone)
    }
}
