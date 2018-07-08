//
//  YFHealineViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/25.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFHealineViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ID = "news"
        /**
         //pss_赞
         空合并运算符  (a ?? b) 将对可选类型a进行空判断，如果a包含一个值就进行解封，否则就返回一个默认值b。
         两个条件：表达式a必须是可选类型，默认值b的类型必须要和a存储值的类型一致
         在 Swift中有一个非常有用的操作符，可以用来快速的对 nil 进行判断。
         ??
         这个操作符可以判断当左侧的值是 非 nil时 Optional值时返回其value，
         左侧为nil时返回其右侧的值。比如
         var level: Int?
         var startLevel = 1
         var currentLevel = level ?? startLevel
         print("currentLevel==\(currentLevel)")
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: ID) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:ID)

        cell.textLabel?.text = "\(String(describing: self.title)) -- 数据"
        return cell
        
    }
 

}
