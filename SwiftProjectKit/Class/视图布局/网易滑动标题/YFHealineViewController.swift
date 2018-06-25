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
        let cell = tableView.dequeueReusableCell(withIdentifier: ID) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:ID)

        cell.textLabel?.text = "\(String(describing: self.title)) -- 数据"
        return cell
        
    }
 

}
