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
    let searchCell_id  = "searchCell_id"
    //MARK:数据源
    lazy var dataDic : [String:Any] = {
        let dataDic = [
            "自定义textview":"",
            "毛玻璃":"",
            "倒计时":"PKTimeVC",
            "删除功能的图片浏览器":"",
            "友盟登录分享":"PKUMVC",
            "数据持久化":"PKSaveVC",
            "视频相关":"PKVideoVC",
            "音频相关":"PKAudioVC",
            "蓝牙相关":"PKBluetoothVC",
            "省市区选择器":"PKCitySelect",
            "oc与web的交互":"OCAndWebInteractionVC",
            "按钮":"YFButtonViewController",
            "标签":"YFLabelViewController",
            "视图布局":"YFViewLayoutViewController",
            "视图切换":"YFViewTransitionViewController",
            "零散知识点":"YFKnowledgeViewController",
            "小项目展示":"YFLittleProjectViewController",
            "动画集合":"YFAnimationsViewController",
            "UIKit":"YFUIKitViewController",
            "仿主流app功能":"YFImitateAppViewController",
            "常用工具类":"YFToolsViewController",
            "数据持久化":"YFDataPersistenceViewController",
            "博客/论坛":"YFBlogViewController",
            "算法":"YFAlgorithmViewController",
            "图片处理相关汇总":"PKPhotoHandle",
            "socket":"PKSocket",
            "环信3.4.1":"",
            "绘图":"PKDrawing"]
            print("------") //按理说应该只打印一次
        return dataDic
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        let textField = UITextField(frame:CGRect(x: 0, y: 0, width: 200, height: 30))
        textField.delegate = self
        textField.backgroundColor = UIColor.yellow
        self.navigationItem.titleView = textField
    }
    
    //MARK:-----tableViewDelegateAndDatasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pss_注1.习惯写上对象的类型
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(searchCell_id)", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "memeda"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        jumpToPageVC()
    }
    //MARK:用户交互
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
    
    //MARK:---------懒加载------
    fileprivate lazy var tableView : UITableView = {[unowned self] in
        //
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(searchCell_id)")
        
        return tableView
        
        }()
    
    fileprivate lazy var functionKitList :[String] = {
        // 其实只要使用一点小技巧就能解决了,强转
        var functionKitList = Array(self.dataDic.keys);
        return functionKitList;
    }()

    
}

extension AlipayViewController{

    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        
        
        
        return true
    }

}

