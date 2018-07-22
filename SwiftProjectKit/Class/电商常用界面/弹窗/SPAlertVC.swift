//
//  SPAlertVC.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/7/23.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickBtn(_ sender: Any) {
        
       test2()
    }
    
    func test1(){
        
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您确定要离开hangge.com吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func test2(){
       XYAlertView.ShareAlert.show()
    }
    
}
