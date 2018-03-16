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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        return tableView
        
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pss_注1.习惯写上对象的类型
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
//        let child = children[indexPath.row]
        cell.textLabel?.text = "memeda"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
  
    

    //
    deinit {
        
    }
}
