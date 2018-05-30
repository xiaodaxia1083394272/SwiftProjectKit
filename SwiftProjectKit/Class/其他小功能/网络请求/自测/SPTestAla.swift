//
//  SPTestAla.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
import Alamofire

class SPTestAla: NSObject {
    //MARK:get请求
    class func queryData(){
        Alamofire.request("http://192.168.1.35:8012/localQuickPurchase/ogMongoAction/getCategory", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                print("请求成功")
                print(response.result.value)
            }else{
                print("请求失败\(String(describing: response.error))")
            }
            
        }
        
    }
    //MARK:测试post请求
    class func queryPostData(){
        Alamofire.request("http://192.168.1.35:8012/localQuickPurchase/shippingAddress/allShippingAddress", method: .post, parameters: ["userName":"17100000076"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if(response.error == nil){
                print("请求成功")
                print(response.result.value)
            }else{
                print("请求失败\(String(describing: response.error))")
            }
            
        }
        
    }
    
    

    
}
