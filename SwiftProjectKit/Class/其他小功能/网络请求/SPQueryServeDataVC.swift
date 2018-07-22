//
//  SPQueryServeDataVC.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
import Alamofire

class SPQueryServeDataVC: UIViewController {

    @IBOutlet weak var showDatatTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func clickQuerydataBtn(_ sender: Any) {
        
//        GJNetWorkTool.tool.requestMainViewControllerData { (result) in
//
//            print("testNetwork")
//
//        }
        
//        let input = ["userName": "17100000020"]
//        SSLoginNetWorkRequest .requestCityList(method: .RequestMethodPOST, params: input as NSDictionary, success: { (mode) in
//
//        }) { (error) in
//
//        }
        
//        let parameters:Dictionary = ["userName":"17100000020"]
//        Alamofire.request(.POST,"http://192.168.1.43:8091/localQuickPurchase/shippingAddress/allShippingAddress", parameters: parameters)
//            .responseJSON { response in
//
//                print("result==\(response.result)")   // 返回结果，是否成功
//                if let jsonValue = response.result.value {
//                    /*
//                     error_code = 0
//                     reason = ""
//                     result = 数组套字典的城市列表
//                     */
//                    print("code: \(jsonValue)")
//                }
//        }
        
//        SPTestAla.queryData()
        

          test1()

    }
}

extension SPQueryServeDataVC{
    func test0(){
        
      SPTestAla.queryPostData()

    }
    func test1(){
        /*
        NetworkManager.request(.get, with: .activityDetailForAward, query: self.model.listParameters(isMore), handle: { (result) in
            
            self.model.update(with: result)
            
            if isMore == false {
                
                self.hud.hideLoading()
                self.tableView.es.stopPullToRefresh()
                self.navigationView.setup(title: self.model.activityItem.title ?? "")
                self.headerView.setup(with: self.model.activityItem)
                
            } else if self.model.hasNextPage {
                
                self.tableView.es.stopLoadingMore()
                
            } else {
                
                self.tableView.es.noticeNoMoreData()
            }
            self.tableView.reloadData()
        })*/
    }
}





