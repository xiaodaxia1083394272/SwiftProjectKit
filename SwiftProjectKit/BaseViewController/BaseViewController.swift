//
//  BaseViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @objc func showAddressBook(){
        print("showAddressBook")
        
    }
    @objc func searchAction(){
        print("searchAction")
        
    }
    @objc func addAction(){
        print("addAction")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //pss_疑
        if (self.isKind(of: AlipayViewController.self)||self.isKind(of:ReputationViewController.self)||self.isKind(of:FriendViewController.self)||self.isKind(of:MoneyViewController.self)==true){
            let friendItem = UIBarButtonItem(image: UIImage(named: "user"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(showAddressBook))
            let searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchAction))
            let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addAction))
            
            self.navigationItem.rightBarButtonItems = [searchItem,friendItem,addItem]
        }
    }


}
