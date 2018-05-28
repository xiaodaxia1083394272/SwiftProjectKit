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
    //pss_swift中字典同级的key不能一样，这样奇葩（貌似oc可以，不过自动去掉了重复的了）
    lazy var dataDic : Dictionary<String,Any> = {
        let dataDic = [
            "自定义textview":"",
            "毛玻璃":"",
            "倒计时":"PKTimeVC",
            "删除功能的图片浏览器":"",
            "友盟登录分享":"PKUMVC",
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
            "图片处理相关汇总":"PKPhotoHandle",
            "socket":"PKSocket",
            "环信3.4.1":"",
            "绘图":"PKDrawing"]
            print("------") //按理说应该只打印一次
        return dataDic
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()

    }
    //MARK:---------设置UI------
    func setUpUI(){
        
        view.addSubview(tableView)
        self.navigationItem.titleView = self.textField

    }
    
    //MARK:-----tableViewDelegateAndDatasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.searchList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pss_注1.习惯写上对象的类型
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(searchCell_id)", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.searchList[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = kFont(13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aimStr = self.searchList[indexPath.row];

        //字符串判断为空，跟oc是不一样的，注意了
        if aimStr.isEmpty{
            return
        }
        let className = self.dataDic[aimStr];
        if let classNameH = className{
           //pss_oc中用NSClassFromString看中了其方便，不过swift中居然这么麻烦，ps：顺便吐槽一句，我可选绑定后貌似还是要强解
           let  mfvc = NSClassFromString(classNameH as! String) as! UIViewController.Type//swifit是强类型语言，所以需要转成目标类型，比如UIViewController
            let fvc = mfvc.init();//还要实例一下，swift已经弱化到连实例一下都不给你弄了
            self.navigationController?.pushViewController(fvc, animated: true)

        }
    
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
    
    fileprivate lazy var textField : UITextField = {
        let textField = UITextField(frame:CGRect(x: 0, y: 0, width: kFitW(200), height: kFitH(30)))
        textField.delegate = self
        textField.backgroundColor = kYellowColor
        textField.placeholder = "搜索关键字"

        
        return textField
    }()
    
    fileprivate lazy var functionKitList :[String] = {
        // 其实只要使用一点小技巧就能解决了,强转
        var functionKitList = Array(self.dataDic.keys);
        return functionKitList;
    }()
        
    fileprivate lazy var searchList : [String] = {
        
        var searchList = self.functionKitList
        
        return searchList
    }()
    
}

//MARK:扩展
extension AlipayViewController{

    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        
        
        
        return true
    }

}

