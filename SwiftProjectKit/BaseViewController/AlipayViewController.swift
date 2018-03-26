//
//  AlipayViewController.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/3/16.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
//pss_3.首页

class AlipayViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    let functionList = ["自定义textView","tabbar模板","毛玻璃"]
    
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
        let textField = UITextField(frame:CGRect(x: 0, y: 0, width: 200, height: 30))
        textField.delegate = self
        textField.backgroundColor = UIColor.yellow
        self.navigationItem.titleView = textField
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        jumpToPageVC()
    }
    //
    func jumpToPageVC(){
        let vc1 = ViewController()
        let vc2 = ViewController()
        let vc3 = ViewController()
        let vc4 = ViewController()
        let vc5 = ViewController()
        vc1.title = "ViewController title1"
        vc2.title = "ViewController title2"
        vc3.title = "ViewController title3"
        vc4.title = "ViewController title4"
        vc5.title = "ViewController title5"

        let vcList = [vc1,vc2,vc3,vc4,vc5]
        let pageViewController = XPageViewController()
       //pss_4.for 循环没有小括号的注意了
        pageViewController.controllers = vcList
  self.navigationController?.pushViewController(pageViewController, animated: true)
    }
}

extension AlipayViewController{
    
    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        
        
        
        return true
    }
    
}

