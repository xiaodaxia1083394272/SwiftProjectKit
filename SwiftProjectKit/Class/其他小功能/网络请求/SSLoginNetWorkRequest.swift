//
//  SSNetWorkText.swift
//  SmartStore_Swift
//
//  Created by maowo－001 on 2017/3/1.
//  Copyright © 2017年 maowo－001. All rights reserved.
//

import UIKit
/*
 具体使用，向上在封装一层，根据你实际的请求，在使用base类时，如果不需要在url之后拼接参数，就更改base里面的默认值，后面每次单例的调用就不需要在管这个属性。这里数据解析用的ObjectMapper.
 */
import ObjectMapper

class SSLoginNetWorkRequest: NSObject {
    
    class func requestCityList(method:RequestMethod,params:NSDictionary,success:@escaping ([SPAddressM])->(),failure:@escaping (Error)->()) -> Void {
        
        SPTestService.shareNetWorkBase.isNeedAccessToken = false
        SPTestService.shareNetWorkBase .RequestParams(url:"http://192.168.1.43:8091/localQuickPurchase/shippingAddress/allShippingAddress", method: method, params: params, success: { (respones) in
            print(respones)
            
            if respones is NSNumber {
                
                print("no success or no Data")
            
            } else {
                
                //解析数据
//                let cityList = Mapper<SPAddressM>().mapArray(JSONArray: respones as! [[String : Any]])
                
//                success(cityList!)
                print("testNetWork")
                
            }
            
        }) { (error) in
            print(error)
        }
        
    }
}
