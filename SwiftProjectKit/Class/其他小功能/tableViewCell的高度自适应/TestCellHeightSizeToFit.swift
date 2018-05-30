//
//  TestCellHeightSizeToFit.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/5/31.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit


class TestCellHeightSizeToFit: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellId = "testSizeToFitCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    //MARK:-----tableViewDelegateAndDatasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pss_注1.习惯写上对象的类型
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
//        cell.selectionStyle = .none
//        cell.textLabel?.text = self.searchList[indexPath.row]
//        cell.textLabel?.textAlignment = .center
//        cell.textLabel?.font = kFont(13)
//        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }


}
