//
//  SPDelegateVC.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPDelegateVC: UIViewController,BuyTicketDelegate {

    @IBOutlet weak var delegateLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhiteColor;

    }


    @IBAction func clickDelegateCallBack(_ sender: Any) {
        
        
        let testDelegateObj = SPTestDelegateObject()
        testDelegateObj.delegate = self
        testDelegateObj.goToBeijing()
    }
    
    //3.MARK:指定委托的对象，swift直接就不用，就是这么任性
    func buyTicket(testCallBack:String){
       
       print("\(testCallBack)")
        delegateLB.font = kFont(13)
        delegateLB.text = testCallBack
    }
    
    
    
}
