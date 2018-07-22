//
//  RequestResultModel.swift.swift
//  HappyOnigiri
//
//  Created by Willima Lee on 12/07/2017.
//  Copyright © 2017 飞进科技. All rights reserved.
//

import Foundation
import WMJSONKit

public class RequestResultModel {
  
  var isDebug: Bool = false
  
  public var error: String?
  public var data: Any?
  public var json: WMJSON = WMJSON()
  
  public var arrayJson: [Any]? {
    
    return self.data as? [Any]
  }
  
  public var dicJson: [String : Any]? {
    
    return self.data as? [String : Any]
  }
  
  init(_ data: Data?) {
    
    #if DEBUG
    
      self.isDebug = true
      
    #endif
      
    guard let data = data else {
      
      self.error = self.isDebug ? "无响应的Data数据" : "网络异常"
      return
    }
    guard let reusltJson = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
      
      self.error = String(data: data, encoding: .utf8) ?? "解析Json异常"
      return
    }
    guard let resultCode = (reusltJson as? [String : Any])?["result"] as? Int else {
      
      self.error = "无法读取返回状态值"
      return
    }
    
    //
    if resultCode != 1 {
      
      self.error = (reusltJson as? [String : Any])?["msg"] as? String ?? String(data: data, encoding: .utf8) ?? "解析Json异常"
      
      return
    }
    
    self.json = WMJSON(data)["data"]
    //
    self.data = (reusltJson as? [String : Any])?["data"]
    #if DEBUG
      print(self.data ?? ["Error" : "异常"])
    #endif
  }
  
}









