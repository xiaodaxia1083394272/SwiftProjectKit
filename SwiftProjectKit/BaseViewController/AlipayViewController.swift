//
//  AlipayViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class AlipayViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    fileprivate lazy var tableView:UITableView = {[unowned self] in
        //
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        return tableView
        
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pss_注1，习惯在声明前加特定的类型
         var cell = tableView .dequeueReusableCell(withIdentifier: "memeda")
        if ((cell) != nil){
            cell = UITableViewCell();
        }
        return cell!;
    }

    //
    deinit {
        
    }
}
