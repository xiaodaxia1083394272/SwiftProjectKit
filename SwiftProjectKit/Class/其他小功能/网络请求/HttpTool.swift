//
//  HttpTool.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
import Alamofire

class HttpTool: NSObject {
    
    //创建单例
    static let shareInstance:HttpTool = {
        
        let tools = HttpTool()
        return tools
        
    }()

}
/*
//MARK: - GET和POST的简单封装
extension HttpTool {
    /// 发送POST请求
    func postRequest(urlString:String, params : [String : Any], finished : @escaping (_ response : [String :AnyObject]?,_ error:NSError?)->()) {
        
        
        Alamofire.request(urlString, method: .post, parameters: params)
            .responseJSON { (response)in
                
                if response.result.isSuccess{
                    
                    finished(response.result.valueas? [Any],nil)
                }else{
                    
                    finished(nil,response.result.erroras NSError?)
                    
                }
        }
        
    }
    
    //发送get请求
    
    func getRequest(urlString:String, params : [String : Any], finished : @escaping (_ response : [String :AnyObject]?,_ error:NSError?)->()) {
        
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response)in
                
                if response.result.isSuccess{
                    
                    finished(response.result.valueas? [AnyObject],nil)
                }else{
                    
                    finished(nil,response.result.erroras, NSError?)
                    
                }
        }
    }
    
    
}
*/
